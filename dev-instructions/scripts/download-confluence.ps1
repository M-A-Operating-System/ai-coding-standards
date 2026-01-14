[CmdletBinding()]
param(
    [string]$OutDir = "."
)

# Reference Implementation:
# Simple downloader for a Confluence page (by ID or URL) and optionally its descendants
# Saves each page as XHTML (Confluence storage) or HTML (export_view) with front-matter metadata.
# NO PRETTY PRINTING. PRESERVES RAW STORAGE FORMAT.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Load .env if present to set folder-scoped env vars
$envPath = Join-Path -Path (Get-Location) -ChildPath '.env'
if (Test-Path $envPath) {
    foreach ($line in Get-Content -LiteralPath $envPath) {
        if ($line -match '^\s*#') { continue }
        if ($line -match '^(?<k>[A-Za-z_][A-Za-z0-9_]*)=(?<v>.*)$') {
            $key = $Matches['k']
            $val = $Matches['v']
            Set-Item -Path "Env:$key" -Value $val
        }
    }
} else {
    Write-Warning ".env file not found in $((Get-Location).Path). Credentials may be missing."
}


# After loading .env and confluence.config, check required variables
# (MOVED BELOW VARIABLE ASSIGNMENTS)

# Try to load config from OutDir/confluence.config (Simple Key=Value format)
$configPath = Join-Path -Path $OutDir -ChildPath 'confluence.config'
## Initialize variables
$BaseUrl = $null
$PageId = $null
$Email = $null
$ApiToken = $null
Write-Host "DEBUG: Looking for confluence.config at $configPath"
if (Test-Path $configPath) {
    $rawConfig = Get-Content -LiteralPath $configPath -Raw
    Write-Host "DEBUG: confluence.config contents:\n$rawConfig"
    try {
        # ConvertFrom-StringData parses "Key=Value" lines into a hashtable
        $config = $rawConfig | ConvertFrom-StringData
        if ($config.ContainsKey('BaseUrl')) { $BaseUrl = $config['BaseUrl'] }
        if ($config.ContainsKey('PageId')) { $PageId = $config['PageId'] }
        # Email and ApiToken are NOT in confluence.config, always fallback to env
    }
    catch {
        Write-Warning "Failed to load config from $configPath : $_"
    }
} else {
    Write-Warning "confluence.config not found at $configPath"
}


# Always set Email and ApiToken from env after .env is loaded
$Email = $env:CONF_EMAIL
$ApiToken = $env:CONF_TOKEN

# Debug output for loaded values
Write-Host "DEBUG: BaseUrl = '$BaseUrl'"
Write-Host "DEBUG: PageId = '$PageId'"
Write-Host "DEBUG: Email = '$Email'"
Write-Host "DEBUG: ApiToken = '$ApiToken'"
# After all loading, check required variables and throw if missing
if (-not $BaseUrl) { Write-Warning "BaseUrl not set from confluence.config." }
if (-not $PageId) { Write-Warning "PageId not set from confluence.config." }
if (-not $Email) { Write-Warning "CONF_EMAIL not set from .env." }
if (-not $ApiToken) { Write-Warning "CONF_TOKEN not set from .env." }
if (-not $BaseUrl -or -not $PageId -or -not $Email -or -not $ApiToken) {
    throw "Missing credentials: set BaseUrl and PageId via confluence.config, CONF_EMAIL and CONF_TOKEN via .env."
}

function New-AuthHeader {
    <#
    .SYNOPSIS
        Creates a Basic Auth header for Confluence API.
    .PARAMETER Email
        The user email address.
    .PARAMETER ApiToken
        The Atlassian API token.
    #>
    param(
        [string]$Email,
        [string]$ApiToken
    )
    $pair = "${Email}:${ApiToken}"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($pair)
    $base64 = [Convert]::ToBase64String($bytes)
    return @{ Authorization = "Basic $base64"; 'Accept' = 'application/json' }
}

function Get-PageIdFromUrl {
    <#
    .SYNOPSIS
        Extracts the page ID from a Confluence web link.
    #>
    param([string]$Url)
    # Expecting .../pages/<id>/...
    if ($Url -match "/pages/([0-9]+)/") { return $Matches[1] }
    throw "Unable to parse page id from URL: $Url"
}

function Invoke-ConfluenceGet {
    <#
    .SYNOPSIS
        Wraps Invoke-RestMethod for Confluence calls with error handling.
    #>
    param(
        [string]$Path,
        [hashtable]$Headers
    )
    $uri = "$BaseUrl$Path"
    try {
        $response = Invoke-RestMethod -Method GET -Uri $uri -Headers $Headers -ErrorAction Stop
    }
    catch {
        $message = $_.Exception.Message
        if ($message -match '\(401\)') { throw "Unauthorized (401) calling $uri. Check CONF_EMAIL/CONF_TOKEN are correct and have Confluence access." }
        if ($message -match '\(403\)') { throw "Forbidden (403) calling $uri. The account lacks permission for this content." }
        if ($message -match '\(404\)') { throw "Not Found (404) calling $uri. Verify the BaseUrl ($BaseUrl) and path are correct, and the page exists." }
        throw
    }
    return $response
}

function Get-Page {
    <#
    .SYNOPSIS
        Retrieves a single page content (storage and export_view) from Confluence API.
    #>
    param(
        [string]$Id,
        [hashtable]$Headers
    )
    if (-not $Id -or -not ($Id -match '^[0-9]+$')) { throw "Invalid page id: '$Id'" }
    $path = ("/wiki/rest/api/content/{0}?expand=body.export_view,body.storage,version,ancestors,space" -f $Id)
    return Invoke-ConfluenceGet -Path $path -Headers $Headers
}

function Get-Children {
    <#
    .SYNOPSIS
        Retrieves direct child pages of a given page.
    #>
    param(
        [string]$Id,
        [hashtable]$Headers
    )
    if (-not $Id -or -not ($Id -match '^[0-9]+$')) { throw "Invalid page id: '$Id'" }
    $start = 0
    $limit = 100
    $results = @()
    while ($true) {
        $path = ("/wiki/rest/api/content/{0}/child/page?limit={1}&start={2}" -f $Id, $limit, $start)
        $response = Invoke-ConfluenceGet -Path $path -Headers $Headers
        if ($response.results) { $results += $response.results }
        
        # Check for pagination using psbase property check or try/catch to avoid strict mode error
        $hasNext = $false
        if ($response.psobject.Properties[' _links'] -or $response.psobject.Properties['_links']) {
             if ($response._links.psobject.Properties['next']) {
                 $hasNext = $true
             }
        }
        
        if (-not $hasNext) { break }
        $start += $limit
    }
    return $results
}

function Test-ConfluenceAuth {
    <#
    .SYNOPSIS
        Verifies authentication by requesting a lightweight resource.
    #>
    param([hashtable]$Headers)
    $probe = "/wiki/rest/api/space?limit=1"
    try {
        $null = Invoke-ConfluenceGet -Path $probe -Headers $Headers
        return $true
    }
    catch {
        Write-Warning $_
        return $false
    }
}

function ConvertTo-SafeFileName {
    <#
    .SYNOPSIS
        Sanitizes a string for use as a filename.
    #>
    param([string]$Name)
    $name = $Name -replace '[\\/:*?"<>|]', '-'
    $name = $name.Trim()
    if ($name.Length -gt 120) { $name = $name.Substring(0, 120) }
    return $name
}

function Get-StringHash {
    <#
    .SYNOPSIS
        Computes MD5 hash of string content for change detection.
    #>
    param([string]$Content)
    if ([string]::IsNullOrEmpty($Content)) { return "" }
    # Normalize line endings to LF and trim whitespace to ensure consistency
    $normalizedContent = $Content.Replace("`r`n", "`n").Trim()
    $hasher = [System.Security.Cryptography.MD5]::Create()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($normalizedContent)
    $hashBytes = $hasher.ComputeHash($bytes)
    return [System.BitConverter]::ToString($hashBytes).Replace('-', '').ToLowerInvariant()
}

function Get-MacroCounts {
    <#
    .SYNOPSIS
        Counts occurrences of specific Confluence macros in content.
    #>
    param([string]$Content)
    $counts = @{}
    $counts.structured_macro = ([regex]::Matches($Content, '<ac:structured-macro\b')).Count
    $counts.image = ([regex]::Matches($Content, '<ac:image\b')).Count
    $counts.link = ([regex]::Matches($Content, '<ac:link\b')).Count
    return $counts
}

function Save-Page {
    <#
    .SYNOPSIS
        Saves the page content to disk with front matter metadata.
    #>
    param(
        $Page,
        [string]$Dir,
        [string]$Format
    )
    $title = $Page.title
    $fileBase = ConvertTo-SafeFileName $title
    $id = $Page.id
    $version = $null
    if ($Page.psobject.Properties.Name -contains 'version') { $version = $Page.version.number }
    $space = $null
    if ($Page.psobject.Properties.Name -contains 'space' -and $Page.space) { $space = $Page.space.key }
    $url = $null
    if ($Page.psobject.Properties.Name -contains '_links' -and $Page._links -and $Page._links.webui) {
        $url = "$BaseUrl$($Page._links.webui)"
    }
    elseif ($Page.psobject.Properties.Name -contains 'links' -and $Page.links -and $Page.links.self) {
        $url = $Page.links.self
    }
    if (-not (Test-Path $Dir)) { New-Item -ItemType Directory -Force -Path $Dir | Out-Null }
    # Always save flat with ID prefix to avoid long paths
    $nameBase = "$id-$fileBase"

    if ($Format -eq 'xhtml') {
        # Save raw Confluence storage format (XHTML)
        $xhtml = $null
        if ($Page.body -and $Page.body.storage -and $Page.body.storage.value) { $xhtml = $Page.body.storage.value }
        elseif ($Page.body -and $Page.body.value) { $xhtml = $Page.body.value }

        # NO PRETTY PRINTING. PRESERVE RAW CONTENT.
        $rawContent = $xhtml

        $contentHash = Get-StringHash -Content $rawContent

        $macroCounts = Get-MacroCounts -Content $rawContent
        $front = "---$([System.Environment]::NewLine)source: $url$([System.Environment]::NewLine)confluence_id: $id$([System.Environment]::NewLine)space: $space$([System.Environment]::NewLine)version: $version$([System.Environment]::NewLine)retrieved: $(Get-Date -Format o)$([System.Environment]::NewLine)format: xhtml$([System.Environment]::NewLine)content_hash: $contentHash$([System.Environment]::NewLine)macro_structured_macro: $($macroCounts.structured_macro)$([System.Environment]::NewLine)macro_image: $($macroCounts.image)$([System.Environment]::NewLine)macro_link: $($macroCounts.link)$([System.Environment]::NewLine)---$([System.Environment]::NewLine)"
        $outPath = Join-Path $Dir "$nameBase.xhtml"

        # Concatenate front matter and raw content. 
        $fileContent = "$front$rawContent"

        # Save with UTF8 no BOM
        $fileContent | Out-File -FilePath $outPath -Encoding UTF8

        return [pscustomobject]@{ Id = $id; Title = $title; Version = $version; Format = 'xhtml'; Path = $outPath; Macros = $macroCounts }
    }
    elseif ($Format -eq 'html') {
        $html = $null
        if ($Page.body -and $Page.body.export_view -and $Page.body.export_view.value) { $html = $Page.body.export_view.value }

        $rawContent = $html

        $contentHash = Get-StringHash -Content $rawContent

        $macroCounts = Get-MacroCounts -Content $rawContent
        $front = "---$([System.Environment]::NewLine)source: $url$([System.Environment]::NewLine)confluence_id: $id$([System.Environment]::NewLine)space: $space$([System.Environment]::NewLine)version: $version$([System.Environment]::NewLine)retrieved: $(Get-Date -Format o)$([System.Environment]::NewLine)format: html$([System.Environment]::NewLine)content_hash: $contentHash$([System.Environment]::NewLine)macro_structured_macro: $($macroCounts.structured_macro)$([System.Environment]::NewLine)macro_image: $($macroCounts.image)$([System.Environment]::NewLine)macro_link: $($macroCounts.link)$([System.Environment]::NewLine)---$([System.Environment]::NewLine)"
        $outPath = Join-Path $Dir "$nameBase.html"
        $fileContent = "$front$rawContent"
        $fileContent | Out-File -FilePath $outPath -Encoding UTF8
        return [pscustomobject]@{ Id = $id; Title = $title; Version = $version; Format = 'html'; Path = $outPath; Macros = $macroCounts }
    }
    else {
        throw "Unsupported format '$Format'. Use 'xhtml' or 'html'."
    }
}

function Invoke-TreeWalk {
    <#
    .SYNOPSIS
        Recursively downloads a page and its descendants.
    #>
    param(
        [string]$RootId,
        [hashtable]$Headers,
        [string]$OutDir,
        [string]$Format,
        [int]$MaxDepth
    )
    $seenPages = New-Object System.Collections.Generic.HashSet[string]

    function Recurse([string]$Id, [string]$Dir, [int]$Depth) {
        if ($seenPages.Contains($Id)) { return }
        $null = $seenPages.Add($Id)
        $page = Get-Page -Id $Id -Headers $Headers
        $saved = Save-Page -Page $page -Dir $Dir -Format $Format
        if ($saved) {
            Write-Verbose "Saved page id=$($saved.Id) v$($saved.Version) format=$($saved.Format) macros=[structured:$($saved.Macros.structured_macro),image:$($saved.Macros.image),link:$($saved.Macros.link)] -> $($saved.Path)"
        }

        # Stop recursion when reaching the maximum depth
        if ($Depth -ge $MaxDepth) { return }

        $children = Get-Children -Id $Id -Headers $Headers
        
        # Safe count check for Strict Mode
        $childCount = 0
        if ($children) {
             if ($children.psobject.Properties['Count']) { $childCount = $children.Count }
             elseif ($children -is [array]) { $childCount = $children.Length }
             else { $childCount = 1 } # Single object
        }

        if ($childCount -gt 0) {
            Write-Verbose "Found $childCount child page(s) under id=$Id"
        }
        foreach ($childPage in $children) {
            # Always write to the same directory (flat)
            $subDir = $Dir
            Recurse -Id $childPage.id -Dir $subDir -Depth ($Depth + 1)
        }
    }

    # Root starts at depth 0
    Recurse -Id $RootId -Dir $OutDir -Depth 0
}

# Entry
$headers = New-AuthHeader -Email $Email -ApiToken $ApiToken

# Preflight auth check
if (-not (Test-ConfluenceAuth -Headers $headers)) {
    throw "Confluence auth or BaseUrl is not valid. Ensure BASE_URL, CONF_EMAIL, and CONF_TOKEN are set (via .env) and correct."
}

if ($PageId) {
    $rootId = $PageId
}
else {
    throw "You must provide PageId in confluence.config."
}

Write-Verbose "Starting tree download from page id=$rootId (max depth 5)"
Invoke-TreeWalk -RootId $rootId -Headers $headers -OutDir $OutDir -Format 'xhtml' -MaxDepth 5

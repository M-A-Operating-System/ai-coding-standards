<#
.SYNOPSIS
    Bootstraps Claude Code integration for a project that uses ai-coding-standards as a submodule.

.DESCRIPTION
    Default (minimal): copies the ready-to-use CLAUDE.md from the submodule root to the project root.
    Extended (-Extended): copies CLAUDE.md.template instead — includes TODO sections for build commands,
    architecture notes, and project-specific conventions that you fill in.

    Also copies .claude/settings.json to the project .claude/ directory.

.PARAMETER ProjectRoot
    Path to the target project root. Defaults to the parent of the ai-coding-standards submodule.

.PARAMETER Extended
    Copy CLAUDE.md.template (extended project starter) instead of the minimal CLAUDE.md.

.PARAMETER Force
    Overwrite CLAUDE.md if it already exists.

.EXAMPLE
    # Minimal setup — run from inside the ai-coding-standards submodule folder:
    .\scripts\setup_claude.ps1

    # Extended setup with project-specific TODO sections:
    .\scripts\setup_claude.ps1 -Extended

    # Target a specific project root:
    .\scripts\setup_claude.ps1 -ProjectRoot "C:\projects\my-app"
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ProjectRoot = (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)),
    [switch]$Extended,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$SubmoduleRoot = Split-Path -Parent $PSScriptRoot  # ai-coding-standards/
$SourceClaude  = if ($Extended) {
    Join-Path $SubmoduleRoot 'CLAUDE.md.template'
} else {
    Join-Path $SubmoduleRoot 'CLAUDE.md'
}
$SettingsPath  = Join-Path $SubmoduleRoot '.claude\settings.json'
$DestClaude    = Join-Path $ProjectRoot 'CLAUDE.md'
$DestClaudeDir = Join-Path $ProjectRoot '.claude'
$DestSettings  = Join-Path $DestClaudeDir 'settings.json'

Write-Host "=== Claude Code Setup ===" -ForegroundColor Cyan
Write-Host "Project root : $ProjectRoot"
Write-Host "Submodule    : $SubmoduleRoot"
Write-Host "Mode         : $(if ($Extended) { 'Extended (CLAUDE.md.template)' } else { 'Minimal (CLAUDE.md)' })"

# --- Validate source exists ---
if (-not (Test-Path $SourceClaude)) {
    Write-Error "Source not found: $SourceClaude"
    exit 1
}

# --- Copy CLAUDE.md ---
if ((Test-Path $DestClaude) -and -not $Force) {
    Write-Warning "CLAUDE.md already exists at $DestClaude. Use -Force to overwrite."
} else {
    if ($PSCmdlet.ShouldProcess($DestClaude, 'Create CLAUDE.md')) {
        Copy-Item -Path $SourceClaude -Destination $DestClaude -Force
        Write-Host "[OK] Created $DestClaude" -ForegroundColor Green
        if ($Extended) {
            Write-Host "     -> Edit the TODO sections in CLAUDE.md to describe your project." -ForegroundColor Yellow
        }
    }
}

# --- Copy .claude/settings.json ---
if (-not (Test-Path $DestClaudeDir)) {
    if ($PSCmdlet.ShouldProcess($DestClaudeDir, 'Create .claude directory')) {
        New-Item -ItemType Directory -Path $DestClaudeDir | Out-Null
    }
}

if ((Test-Path $DestSettings) -and -not $Force) {
    Write-Warning ".claude/settings.json already exists. Use -Force to overwrite."
} else {
    if (Test-Path $SettingsPath) {
        if ($PSCmdlet.ShouldProcess($DestSettings, 'Copy .claude/settings.json')) {
            Copy-Item -Path $SettingsPath -Destination $DestSettings -Force
            Write-Host "[OK] Created $DestSettings" -ForegroundColor Green
        }
    } else {
        Write-Warning ".claude/settings.json template not found at $SettingsPath — skipping."
    }
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
if ($Extended) {
    Write-Host "  1. Open CLAUDE.md and fill in the TODO sections"
} else {
    Write-Host "  1. CLAUDE.md is ready to use — no edits required for minimal setup"
    Write-Host "     Run with -Extended to get a version with project-specific TODO sections"
}
Write-Host "  2. Review .claude/settings.json and add project-specific command permissions"
Write-Host "  3. Commit CLAUDE.md and .claude/settings.json to your project repo"
Write-Host "  4. Ensure the submodule is registered in .gitmodules:"
Write-Host "       git submodule add <url> ai-coding-standards"

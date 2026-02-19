"""
svg2png.py

Converts SVG images to PNG format with configurable output size.

Usage:
    python svg2png.py --input input.svg --output output.png --width 800 --height 600

Requires: cairosvg
Install: pip install svglib reportlab
"""

import argparse
import os
import sys
from svglib.svglib import svg2rlg
from reportlab.graphics import renderPM
from xml.etree import ElementTree

def resize_drawing(drawing, width=None, height=None):
    # Resize drawing proportionally if width or height is specified
    if width or height:
        orig_width = drawing.width
        orig_height = drawing.height
        if width and not height:
            scale = width / orig_width
        elif height and not width:
            scale = height / orig_height
        elif width and height:
            scale = min(width / orig_width, height / orig_height)
        else:
            scale = 1.0
        drawing.width *= scale
        drawing.height *= scale
        for el in drawing.contents:
            if hasattr(el, 'transform'):  # scale child elements
                el.transform = [scale, 0, 0, scale, 0, 0]
    return drawing

def convert_svg_to_png(input_path, output_path, width=None, height=None):
    # Use svglib and reportlab for conversion
    try:
        drawing = svg2rlg(input_path)
        if drawing is None:
            print(f"Could not parse SVG: {input_path}")
            return
        drawing = resize_drawing(drawing, width, height)
        renderPM.drawToFile(drawing, output_path, fmt="PNG")
    except Exception as e:
        print(f"Error converting {input_path}: {e}")

def process_file(input_path, width, height):
    if not input_path.lower().endswith('.svg'):
        return
    output_path = os.path.splitext(input_path)[0] + '.png'
    try:
        convert_svg_to_png(input_path, output_path, width, height)
        print(f"Converted {input_path} to {output_path}")
    except Exception as e:
        print(f"Error converting {input_path}: {e}")

def process_directory(directory, width, height):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.lower().endswith('.svg'):
                svg_path = os.path.join(root, file)
                process_file(svg_path, width, height)

def main():
    parser = argparse.ArgumentParser(description='Convert SVG to PNG with size options. Accepts file or directory.')
    parser.add_argument('--input', required=True, help='Path to input SVG file or directory')
    parser.add_argument('--width', type=int, help='Output width in pixels')
    parser.add_argument('--height', type=int, help='Output height in pixels')
    args = parser.parse_args()
    input_path = args.input
    width = args.width
    height = args.height
    if os.path.isfile(input_path):
        process_file(input_path, width, height)
    elif os.path.isdir(input_path):
        process_directory(input_path, width, height)
    else:
        print(f"Input path not found: {input_path}")
        sys.exit(1)

if __name__ == '__main__':
    main()

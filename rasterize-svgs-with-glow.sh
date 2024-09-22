#!/bin/sh

# this script converts each SVG files in $OUT_ROOT_DIR directory to PNG with optimized size
# it implies that you previously executed ./colorize-svgs.sh at least once before (even for default white on black colors)

# Dependencies:
# https://github.com/sharkdp/fd
# https://github.com/RazrFalcon/resvg
# https://github.com/shssoichiro/oxipng

# final artifacts are created in this gitignored _out directory
OUT_ROOT_DIR='_out'


# should be a few shades lighter than whatever the FG intut to colorize-svgs was
DEFAULT_GLOW='#fff'
DEFAULT_BACKGROUND='#000'
GLOW="$DEFAULT_GLOW"
BACKGROUND="$DEFAULT_BACKGROUND"

if test -n "$1"; then
  GLOW="$1"
fi
if test -n "$2"; then
  BACKGROUND="$2"
fi

if test ! -d "$OUT_ROOT_DIR"; then
  echo "directory '$OUT_ROOT_DIR' does not exist"
  echo "run ./colorize-svgs.sh to create it and populate its content with colorized (or default) SVG files"
  exit 1
fi

i=0
for SVG in $(fdfind . "$OUT_ROOT_DIR" --extension svg); do
  PNG="$(dirname "$SVG")/$(basename "$SVG" .svg).png"
  if test ! -f "$PNG"; then
    i=$((i+1))
    echo "$i $PNG"
    rendersvg "$SVG" "$PNG"
    convert \
      $PNG \
        \( +clone \
          -alpha extract \
          -blur 0x7 \
          -level 0,50% \
          -background "$GLOW" \
          -alpha Shape \
        \) \
        -compose DstOver -composite \
        -background "$BACKGROUND" \
        -compose Over -layers flatten \
        $PNG
    oxipng --opt 4 --interlace 1 --strip safe "$PNG"
  fi
done

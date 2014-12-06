#!/bin/bash
#
# Install:
#
#     $ brew install ffmpeg
#     $ brew install imagemagick
#
# Usage:
#
#     $ chmod +x conv_gif.sh
#     $ ./conv_gif.sh input.(mp4|mov|...) output.gif [FRAMERATE=15]
#
FRAMERATE=$3

if test $# -le 0  ; then
    echo "Usage: ./conv_gif.sh input.(mp4|mov|...) output.gif [FRAMERATE=15]"
    exit -1
fi

if [ -z $3 ]; then
    FRAMERATE=15
fi

mkdir tmp
ffmpeg -i $1 -vf scale=320:-1 -r ${FRAMERATE} tmp/%04d.png
convert tmp/*.png $2
rm -fr tmp

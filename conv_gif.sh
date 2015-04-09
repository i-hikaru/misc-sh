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
INPUT=$1
OUTPUT=$2
BEGIN=$3
TIME=$4

if [ $# -le 0 ]; then
    echo "Usage: ./conv_gif.sh input.(mp4|mov|...) output.gif [FRAMERATE=15]"
    exit -1
fi

mkdir tmp
# ffmpeg -i $INPUT -vf scale=480:-1 -r 15 -ss $BEGIN -t $TIME tmp/%04d.png
ffmpeg -i $INPUT -vf scale=480:-1 -ss $BEGIN -t $TIME tmp/%04d.png
# convert tmp/*.png $OUTPUT
# cd tmp
# seq -f %04g.png 10 3 72
num_tmp=`find tmp/ -name "*.png" | wc -l`
num=`expr $num_tmp - 10`
# convert -delay 1x8 `seq -f tmp/%04g.png 10 3 $num` \
#     -ordered-dither o8x8,8 \
#     -coalesce -layers OptimizeTransparency +map $OUTPUT
convert +dither -delay 1x8 `seq -f tmp/%04g.png 10 3 $num` \
    -coalesce -layers OptimizeTransparency +map $OUTPUT
rm -fr tmp

exit 0

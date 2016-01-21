#!/bin/bash
if [ $# -lt 2 ]
	then 
		echo -e "Usage: ${0##*/} [OPTIONS] INPUT OUTPUT\n  -s/--scale Scale is valid between 0-100\n  -b/--border Number of pixels to be added as border"
		exit
fi
SCALE=100
BORDER=15
while [[ $# > 2 ]]
do
key="$1"

case $key in
    -s|--scale)
    SCALE="$2"
    shift # past argument
    ;;
    -b|--border)
    BORDER="$2"
    shift # past argument
    ;;
    *)
    echo "Unknown option: $key"        # unknown option
    exit
    ;;
esac
shift # past argument or value
done
INPUT=$1
OUT=$2
GSOPT="-q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -dMaxBitmap=500000000 -dAlignToPixels=0 -dGridFitTT=2 -sDEVICE=pngalpha -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sOutputFile=- -r300x300 -"

cat $INPUT| ./dformat/src/dformat.awk | groff -p| gs $GSOPT | convert - -trim -resize $SCALE% -bordercolor none -border 15 png:$OUT
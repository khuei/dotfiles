#!/bin/sh
#
# [m]usic

[ "$1" ] || exit 1

youtube-dl \
	--extract-audio \
	--audio-format mp3 \
	--prefer-ffmpeg \
	--add-metadata \
	--audio-quality 0 \
	--embed-thumbnail \
	"$1"

#!/bin/bash
#
# I compose all descriptors (or a specific set specified on the command line)
# in the current directory's children into the 'target' directory

if [ "$1" = "" -o "$1" = "-h" -o "$1" = "--help" ]; then
	echo "Usage: $0 <format> [<cardset> [<cardset> ... ] ]"
	echo "  compose all cardsets w/in the current directory, or a specific"
	echo "  descriptor (or list of descriptors), into the specified format"
	exit 0
fi

cd `dirname $0`
dir=`pwd`
JOPTS=""

if [ ! -d .compositor ]; then
	echo "you need to run install.sh first."
	exit 1
fi

function generate() {
	echo "----------------------------------------------------------------------"
	java $JOPTS -jar .compositor/target/card-creator-*-all.jar compose $1 $format target/`basename $1 | cut -d . -f 1`
}

format=$1
shift

if [ "$format" == "png" ]; then
	JOPTS="$JOPTS -DimageWidth=400"
elif [ "$format" == "pdf" ]; then
	JOPTS="$JOPTS -Xmx512m"
fi

if [ "$1" == "" ]; then
	for i in `find . -maxdepth 2 -mindepth 2 -type f -name "*.md" | egrep '\./([^/]+)/\1\.md'`; do
		generate $i
	done
else
	while [ "$1" != "" ]; do
		generate $1
		shift
	done
fi

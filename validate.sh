#!/bin/bash
#
# I validate all descriptors (or a specific set specified on the command line)
# in the current directory's children.

if [ "$1" = "-h" -o "$1" = "--help" ]; then
	echo "Usage: $0 [cardset [cardset ... ] ]"
	echo "  validate all cardsets w/in the current directory, or a specific"
	echo "  descriptor (or list of descriptors)"
	exit 0
fi

cd `dirname $0`
dir=`pwd`

if [ ! -d .compositor ]; then
	echo "you need to run install.sh first."
	exit 1
fi

function validate() {
	echo "----------------------------------------------------------------------"
	java -jar .compositor/target/card-creator-*-all.jar validate $1
}

if [ "$1" == "" ]; then
	for i in `find . -depth 2 -type f -name "*.md" | egrep '\./([^/]+)/\1\.md'`; do
		validate $i
	done
else
	while [ "$1" != "" ]; do
		validate $1
		shift
	done
fi

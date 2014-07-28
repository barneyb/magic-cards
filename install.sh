#!/bin/bash
#
# I will install the latest version of composition framework (or a
# different version specified on the command line) and get everything
# ready for composing cardsets into distributable assets.

if [ "$1" = "-h" -o "$1" = "--help" ]; then
	echo "Usage: $0"
	# echo "Usage: $0 [version]"
	echo "  ensure the composition framework is ready to run"
	# echo "  the 'version' parameter must be a tag in Git indicating the"
	# echo "  specific version of the compositor to install.  Passing 'list'"
	# echo "  as the version will list the available versions."
	exit 0
fi

function cleanDir() {
	dir=$1
	if [ -d $dir ]; then
		rm -rf $dir
	elif [ -f $dir ]; then
		echo "There is a malformed '$dir' file in the way.  Deleted it and try again."
	fi
	mkdir $dir
}

cd `dirname $0`

if [ -d .compositor ]; then
	cd .compositor
	if [ -d .git ]; then
		if [ `git status --porcelain | wc -l` -ne 0 ]; then
			echo "The '.compositor' directory is not clean.  Reset or commit before re-installing."
			echo
			git status
			exit 3
		fi
		git checkout master
		git pull
	else
		echo "There is a malformed '.compositor' directory in the way.  Deleted it and try again."
		exit 2
	fi
elif [ -f .compositor ]; then
	echo "There is a malformed '.compositor' file in the way.  Deleted it and try again."
	exit 1
else
	git clone https://github.com/barneyb/magic-card-creator.git .compositor
	cd .compositor
	git checkout master
fi

mvn clean package

# get back up to the root dir
cd ..

cleanDir .runner
cp `ls .compositor/target/card-creator-*-SNAPSHOT-all.jar | head` .runner/compositor.jar
unzip -p .runner/compositor.jar META-INF/MANIFEST.MF | grep 'Main-Class:' | head | cut -d : -f 2- > .runner/main-class.txt

echo '.compositor/src/main/resources' > .runner/resources-dir.txt

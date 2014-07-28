#!/bin/bash
#
# I will install the latest version of composition framework (or a
# different version specified on the command line) and get everything
# ready for composing cardsets into distributable assets.

if [ "$1" = "-h" -o "$1" = "--help" ]; then
	echo "Usage: $0 [ <version> ]"
	echo "  ensure the composition framework is ready to run the 'version' parameter must"
	echo "  be one of:"
#	echo "    list    - list the available versions and exit"
#	echo "    latest  - the latest released version"
	echo "    vX.Y.Z  - a specific release (at GitHub)"
	echo "    dev     - the current development HEAD"
	echo "  If no version is specified, 'dev' will be used. The list of available versions"
	echo "  can be found at: https://github.com/barneyb/magic-card-creator/releases"
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

case "$1" in
"" | "dev")
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

	echo '.compositor/src/main/resources' > .runner/resources-dir.txt
	;;
*)
	cleanDir .runner
	cd .runner
	echo "downloading release..."
	curl --fail --location --output compositor.jar https://github.com/barneyb/magic-card-creator/releases/download/$1/card-creator-all.jar
	if [ "$?" -ne "0" ]; then
		echo
		echo "No '$1' release was found on GitHub."
		exit 4
	fi
	unzip compositor.jar assets/* -d assets/
	echo '.runner/assets/' > resources-dir.txt
	cd ..
	;;
esac

unzip -p .runner/compositor.jar META-INF/MANIFEST.MF | grep 'Main-Class:' | head | cut -d : -f 2- > .runner/main-class.txt

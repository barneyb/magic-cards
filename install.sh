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

cd `dirname $0`

if [ -d .compositor ]; then
	cd .compositor
	if [ -d .git ]; then
		git checkout master
		git pull
	else
		exit "There is a malformed 'compositor' directory in the way.  Deleted it and try again."
		exit 2
	fi
elif [ -f .compositor ]; then
	echo "There is a malformed 'compositor' file in the way.  Deleted it and try again."
	exit 1
else
	git clone https://github.com/barneyb/magic-card-creator.git .compositor
	cd .compositor
	git checkout master
fi

# if [ "$1" != "" ]; then
# 	echo
# 	echo "Don't worry about the 'detached HEAD' state message below.  It's expected."
# 	echo
# 	git checkout tags/$1
# fi

mvn clean package
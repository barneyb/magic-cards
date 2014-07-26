magic-cards
===========

A repository for custom sets of Magic: The Gathering cards, ready to be assembled
by the composition toolkit at https://github.com/barneyb/magic-card-creator

The impetus was issues with the card generator at [http://www.mtgcardmaker.com/](http://www.mtgcardmaker.com/)
after which we decided to build our own generator (linked above) and these are the
set definitions to actually create cards.

Usage
-----

The basic usage is:

    ./install.sh
    ./generate.sh png

which will download and and install the compositor, and then take all Markdown files
exactly one level beneath the current directory and run them through the composition
engine to spit out composed images into a subdirectory of `target` (including an
HTML file that just shows each card in a grid for easier preview).

Note that the install script requires both a JDK and Maven to be available on your
`$PATH`, while the generate script only requires a JRE.

You can also list specific cardset descriptors on the command line if you don't want
to generate them all.

Finally, you can use the `validate.sh` script if you want to validate descriptors,
but not actually generate cards.  It doesn't take a renderset key, but does accept
one or more descriptors paths (just like `generate.sh`).

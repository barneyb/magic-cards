magic-cards
===========

A repository for custom sets of Magic: The Gathering cards, ready to be assembled
by the composition toolkit at https://github.com/barneyb/magic-card-creator

The impetus was issues with the card generator at [http://www.mtgcardmaker.com/](http://www.mtgcardmaker.com/)
after which we decided to build our own generator (linked above) and these are the
set definitions to actually create cards.

Each set is defined by a descriptor file and a collection of card artwork as referenced in the descriptor.
There are two formats for descriptors, Markdown and XML.  The former is a lot nicer to work with, but only
supports a subset of functionality.  The XML format supports the full functionality of the composition toolkit,
but is more cumbersome to work with.

The specific features that XML is required for include:

* planeswalkers
* levelers (e.g., Guul Draz Assassin)
* fused spells
* rarity
* overlay artwork
* game symbols in flavor text
* reminder text
* color indicators (i.e., card colors which are not based on casting cost)
* watermarks

This leaves the _vast_ majority of card design choices available using the basic Markdown-based descriptor
format.  A conversion tool will be coming available at some point so it is safe to start with Markdown and
easily convert to XML if/when it becomes necessary.

#!/bin/sh

# Source aliasrc
if [ -f ~/.aliasrc ]; then . ~/.aliasrc
fi

#[ -f ~/.aliasrc ] && . ~/.aliasrc

# Source .xprofile
if [ -f ~/.xprofile ]; then . ~/.xprofile
fi

#[ -f ~/.xprofile ] && . ~/.xprofile


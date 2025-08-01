#!/bin/bash

# Install Python
if [ -x "$(command -v pyenv)" ]; then
    v=3.12.06
    pyenv install $v
    pyenv global $v
fi

# Install node
# this fix coc.vim error
if [ -x "$(command -v nodenv)" ]; then
    v=19.9.0
    nodenv install $v
    nodenv global $v
fi

# Install Ruby
if [ -x "$(command -v rbenv)" ]; then
    v=3.3.0
    rbenv install $v
    rbenv global $v
fi



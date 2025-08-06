#!/bin/bash

which -s brew

install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


# Install Homebrew

if [[ ! $(which -s brew) != 0 ]]; then

    echo "brew not found, installing..."

    if [[ $OSTYPE == darwin* && $CPUTYPE == arm64 ]]; then
        # Install Homebrew with ARM
        if [[ ! -d /opt/homebrew  ]]; then
            echo "ARM version"
            install_homebrew
        fi

        # Install Homebrew with INTEL
        if [[ ! -d /usr/local/Homebrew ]]; then
            echo "INTEL version"
            arch -x86_64 $SHELL
            install_homebrew
        fi
    else
        if [[ ! -d /usr/local/Homebrew ]]; then
            echo "INTEL version"
            install_homebrew
        fi
    fi
else
    echo "Homebrew already installed, path="$(which brew)
    echo "Running update..."

    brew update
    brew bundle --file "$PWD/Brewfile"
fi


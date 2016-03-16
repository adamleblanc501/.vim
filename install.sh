#!/bin/bash

# ask questions
read -n 1 -p "Install things with sudo? [yn] " yn
echo # read -n 1 doesn't make a new line
    case $yn in
        [Yy]* ) SUDO=true;;
        [Nn]* ) SUDO=false;;
            * ) echo "Please answer Yes or No";;
esac

read -n 1 -p "Install YouCompleteMe? [yn] " yn
echo # read -n 1 doesn't make a new line
case $yn in
    [Yy]* ) YCM=true;;
    [Nn]* ) YCM=false;;
        * ) echo "Please answer Yes or No";;
esac

if $YCM; then
    read -n 1 -p "Will you be using Neovim? [yn] " yn
    echo # read -n 1 doesn't make a new line

    case $yn in
        [Yy]* )
            if [[ "$SUDO" == "false" ]]; then
               echo "Sudo was not selected, but must be used for installing YCM with Neovim."
               echo "Either allow sudo, or do not install YCM."
               exit
            fi
            NEO=true
            ;;
        [Nn]* ) NEO=false;;
            * ) echo "Please answer Yes or No";;
    esac
else
    NEO=false
fi

# check dependencies
echo "Make sure cmake, build-essential, python2-dev, pip2, npm, and ruby are installed."

if $YCM; then
    command -v cmake >/dev/null 2>&1 || {
        echo "I require cmake but it's not installed. Aborting."
        echo "install: cmake"
        exit 1;
    }
fi

# neo is currently only set if YCM is selected.
if $NEO; then
    command -v pip2 >/dev/null 2>&1 || {
        echo "I require pip2 but it's not installed. Aborting."
        echo "install: arch: python2-pip, debian: python-pip"
        exit 1;
    }
fi

if $SUDO; then
    command -v npm >/dev/null 2>&1 || {
        echo "I require npm but it's not installed. Aborting."
        echo "install: npm"
        exit 1;
    }

    command -v ruby >/dev/null 2>&1 || {
        echo "I require ruby but it's not installed. Aborting."
        echo "install: ruby"
        exit 1;
    }
fi

echo Creating nvim symlink
ln -s ~/.vim ~/.config/nvim

echo Installing plugins...
git submodule update --init --recursive
echo Done intsalling plugins...
echo Installing fonts...
fonts-install/install.sh
echo Done installing fonts...

# Other deppendencies
echo Installing other dependencies
gem install sass

if $SUDO; then
    sudo npm install -g jshint
fi

echo Done installing other dependencies

if $YCM; then
    echo Installing YouCompleteMe
    # YouCompleteMe
    cd bundle/YouCompleteMe
    python2 ./install.py --clang-completer

    # only required for YCM plugin so far.
    if $NEO; then
        sudo pip2 install neovim
    fi

    echo Done installing YouCompleteMe
fi

echo Note: Some configuration requires external applications:
echo 'xclip, the_silver_searcher, and ctags (or exuberant-ctags)'

#!/bin/bash

read -p "Install things with sudo? [yn] " yn
    case $yn in
        [Yy]* ) SUDO=true;;
        [Nn]* ) SUDO=false;;
            * ) echo "Please anser Yes or No";;
esac

read -p "Install YouCompleteMe? [yn] " yn
case $yn in
    [Yy]* ) YCM=true;;
    [Nn]* ) YCM=false;;
        * ) echo "Please anser Yes or No";;
esac

echo "Make sure cmake, build-essential, python2-dev, pip2, npm, and ruby are installed."

if $YCM; then
    command -v cmake >/dev/null 2>&1 || {
        echo "I require cmake but it's not installed. Aborting."
        echo "install: cmake"
        exit 1;
    }

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

if $SUDO; then
    echo Installing other dependencies
    # Other deppendencies
    sudo su -c "gem install sass"
    sudo npm install -g jshint
    echo Done installing other dependencies

    if $YCM; then
        echo Installing YouCompleteMe
        # YouCompleteMe
        cd bundle/YouCompleteMe
        python2 ./install.py --clang-completer
        sudo pip2 install neovim
        echo Done installing YouCompleteMe
    fi
fi

echo Note: Some configuration requires external applications:
echo \'xclip\', \'the_silver_searcher\'

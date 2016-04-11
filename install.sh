#!/bin/bash

currentdir=$(pwd)

if [ ! -f $HOME/.vimrc ]; then
  echo "Linking .vimrc"
  ln -s $currentdir/vim/vimrc $HOME/.vimrc
fi

if [ ! -d $HOME/.vim  ]; then
  echo "Linking .vim"
  ln -s $currentdir/vim $HOME/.vim
fi

if [ ! -f $HOME/.tmux.conf ]; then
  echo "Linking .tmux.conf"
  ln -s $currentdir/tmux.conf $HOME/.tmux.conf
fi

if [ ! -d $HOME/.vim/bundle ]; then
  echo "Adding bundle dir"
  mkdir $HOME/.vim/bundle
fi

if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
  echo "Installing Vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -f $HOME/.bash_aliases ]; then
  echo "Adding bash aliases"
  ln -s $currentdir/bash_aliases $HOME/.bash_aliases
fi
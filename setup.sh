#!/bin/sh

currentdir=$(pwd)

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if [ ! -f $HOME/.tmux.conf ]; then
  echo "Linking .tmux.conf"
  ln -s $currentdir/tmux.conf $HOME/.tmux.conf
fi

if [ ! -f $HOME/.bash_profile ]; then
  echo "Linking bash profile"
  ln -s $currentdir/bash_profile $HOME/.bash_profile
fi

if [ ! -f $HOME/.bash_aliases ]; then
  echo "Linking bash aliases"
  ln -s $currentdir/bash_aliases $HOME/.bash_aliases
fi

if [ ! -d $HOME/.ssh ] ||  [ ! -f $HOME/.ssh/id_rsa.pub ]; then
  echo "Generating ssh key..."
  ssh-keygen -t rsa -b 4096 -C "jerelmiller@gmail.com"

  if eval "$(ssh-agent -s)" > /dev/null; then
    ssh-add $HOME/.ssh/id_rsa
  fi
fi

echo "Setting up neovim..."
./scripts/symlink_nvim_dotfiles.sh

echo "Setting up Vim Plug..."
./scripts/setup_vim_plug.sh

echo "Setting up dein..."
./scripts/setup_dein.sh

echo "Installing Tmux plugin manager..."
./scripts/install_tmux_plugin_manager.sh

if ! command -v brew > /dev/null; then
  echo "Installing homebrew..."

  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

if brew list | grep -Fq brew-cask; then
  echo "Uninstalling old Homebrew-Cask..."
  brew uninstall --force brew-cask
fi

xcode-select -p > /dev/null

if [ $? -eq 2 ]; then
  echo "Installing xcode command line tools..."
  xcode-select --install
fi

echo "Updating homebrew formulae..."
brew update

brew install git
brew install openssl
brew install the_silver_searcher
brew install tmux
brew install vim
brew install neovim
brew install mysql
brew install postgres
brew install imagemagick
brew install cmake
brew install memcached
brew install redis
brew install libxml2
brew install elixir
brew install yarn
brew install hub
brew install reattach-to-user-namespace

# required by asdf
brew install coreutils
brew install automake
brew install autoconf
brew install libyaml
brew install readline
brew install libxslt
brew install libtool
brew install unixodbc

brew tap caskroom/fonts
brew cask install font-hack-nerd-font

if ! command -v rvm > /dev/null; then
  echo "Installing rvm..."

  curl -sSL https://get.rvm.io | bash -s stable

  echo "Installing latest ruby..."
  rvm install ruby --latest
fi

echo "Configuring ruby..."

gem update --system
gem_install_or_update "bundler"
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

if ! command -v nvm > /dev/null; then
  echo "Installing nvm..."

  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.6/install.sh | bash

  nvm install node
fi

if ! command -v asdf > /dev/null; then
  echo "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0

  source $HOME/.bash_profile

  echo "Installing asdf Elixir plugin"
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

  echo "Installing asdf Erlang plugin"
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
fi

if [ ! -d $HOME/code/fonts ]; then
  cd $HOME/code
  git clone git@github.com:powerline/fonts.git
  cd $HOME/code/fonts
  ./install.sh
  cd $currentdir
fi

tic tmux-256color.terminfo
tic tmux-256color-italic.terminfo

source $HOME/.bash_profile
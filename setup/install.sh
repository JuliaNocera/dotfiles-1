#!/bin/sh

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . ./utils.sh

ask_for_sudo

./xcode.sh
./homebrew.sh
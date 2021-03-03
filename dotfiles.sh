#!/bin/bash

# Some pretty text functions
# Shamelessly stolen from @holman
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  read -p "Press Enter to continue, or Ctrl-C to exit..."
}

printf "\n"
info "Jack's Dotfiles/Environment Script"
printf "\n"

info "Checking prerequisites..."
sudo --version || fail "Missing sudo?!"
git --version || fail "Missing git!"
curl --version || fail "Missing cURL!"
success "Ready to go!"

info "Installing zsh..."
{
sudo apt install zsh
} || {
git clone git@github.com:zsh-users/zsh.git || fail "Couldn't get zsh from git"
cd zsh
./Util/preconfig	|| fail "Zsh preconfiguration failed"
./configure 		|| fail "Zsh configuration failed"
make				|| fail "Zsh make failed"
#make check 			|| fail "Zsh checks failed"
sudo make install 	|| fail "Zsh installation failed"
cd ..
rm -rf zsh
}
success "Installed Zsh"

info "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || fail "oh-my-zsh installation failed"
success "Installed oh-my-zsh"

info "Installing micro..."
{
sudo snap install --classic micro
} || {
curl https://getmic.ro | bash
sudo install ./micro /usr/bin
}
info "Setting micro as default editor..."
echo "SELECTED_EDITOR=\"/usr/bin/micro\""
sudo ln -bs /usr/bin/sensible-editor /usr/bin/edit
success "Installed micro"

printf "\n"
success "Done!"

# zsh configuration file
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Fri Dec 27 23:48:31 CET 2019

# Add local sbin to $PATH.
export PATH="/usr/local/sbin:${PATH}"

# Path to the oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Define how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Configure history stamp format
HIST_STAMPS="yyyy-mm-dd"

# Plugin configuration
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  ansible
  brew
  bundler
  colored-man-pages
  colorize
  docker
  git
  nmap
  osx
  zsh-navigation-tools
  zsh_reload
  history
  kubectl
  virtualenv
)

ZSH_THEME="powerlevel10k/powerlevel10k"

# Load Zsh tools for syntax highlighting and autosuggestions
HOMEBREW_FOLDER="/usr/local/share"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source "${HOMEBREW_FOLDER}/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source "${HOMEBREW_FOLDER}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/Cellar/kube-ps1/0.7.0/share/kube-ps1.sh

# Load oh-my-zsh framework
source "${ZSH}/oh-my-zsh.sh"

# Powerlevel10k configuration
[ -e ${HOME}/.p10k.zsh ] && source ${HOME}/.p10k.zsh

# Local custom plugins
# for item in $(ls -1 ${HOME}/.profile.d/*.plugin.zsh); do
#   [ -e "${item}" ] && source "${item}"
# done
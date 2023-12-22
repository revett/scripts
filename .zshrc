# .bashrc
#
# @author Charlie Revett (@revcd).

# oh-my-zsh configuration taken from their template .zshrc file (start)
# See: https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template

# ---
# Personal.
# ---

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment one of the following lines to change the auto-update behavior.
zstyle ':omz:update' mode reminder # Just remind me to update when it's time.

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Disable themes.
ZSH_THEME=""

# Enable plugins.
plugins=(brew docker docker-compose git golang)

# Set up oh-my-zsh.
source $ZSH/oh-my-zsh.sh

# Disable autocorrect in Zsh.
# https://coderwall.com/p/jaoypq/disabling-autocorrect-in-zsh
unsetopt correct_all

# Include brew packages and apps within path (Apple Silicon only).
if [[ $(uname -m) == 'arm64' ]]; then

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add user go binaries to PATH.
export PATH=$PATH:~/go/bin

# Set default editor.
export EDITOR='code -w'

# Configure Starship prompt.
# https://starship.rs
eval "$(starship init zsh)"

# Setup fzf (Apple Silicon only).
if [[ $(uname -m) == 'arm64' ]]; then
  # Setup fzf
  if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
  fi
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
fi

# Setup fzf (Intel only).
if [[ $(uname -m) == 'x86_64' ]]; then

  if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
  fi
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

# Set up autoenv.
# https://github.com/hyperupcall/autoenv
source $(brew --prefix autoenv)/activate.sh

# Set fnm environment variables.
# https://github.com/Schniz/fnm#shell-setup
eval "$(fnm env --use-on-cd)"

# Default to a specific version of Node.
fnm use v18.17.1

# ---
# Work.
# ---

# Part of core installation process.
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Silence notice from Ginkgo about support.
export ACK_GINKGO_RC=true

# Set up GCP authentication.
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# ---
# Load other bash scripts.
# ---

for file in ~/projects/github.com/revett/dotfiles/.{functions,aliases}; do
  [ -r "$file" ] && source "$file";
done;
unset file;

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
ZSH_THEME=""

export EDITOR=nvim
export BACKGROUND_COLOR="#111111"

export GOPATH="$HOME/local/go"
export XDG_CONFIG_HOME="$HOME/.config"
export PNPM_HOME="$HOME/.local/share/pnpm"

path=(
  "$GOPATH/bin"
  "$HOME/.local/bin"
  "$HOME/.otherbin"
  "/usr/local/sbin"
  "$HOME/local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.cabal/bin"
  "$HOME/.ghcup/bin"
  "/usr/local/cuda-13/bin"
  "$PNPM_HOME"
  "$HOME/.opencode/bin"
  $path
)

export CFLAGS="-I/usr/local/cuda-13/include"
export LD_LIBRARY_PATH="/usr/local/cuda-13/lib64:${LD_LIBRARY_PATH}"
export LIBRARY_PATH="/usr/local/cuda-13/lib64:${LIBRARY_PATH}"

bindkey '^Y' autosuggest-accept
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

alias config='/usr/bin/lazygit --path ~/dotfiles/'

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

eval "$(starship init zsh)"


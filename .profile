# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Neovim remote setup for lazygit
export VISUAL="nvim"
export EDITOR="nvim"
export GIT_EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
alias vim='nvim --listen /tmp/nvim-server.pipe'

export PATH="/opt/riscv/bin:$PATH"
export PATH="/usr/local/texlive/2018/bin/x86_64-linux:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH MANPATH="/usr/local/texlive/2018/texmf-dist/doc/man:$MANPATH"
export MANPATH INFOPATH="/usr/local/texlive/2018/texmf-dist/doc/info:$INFOPATH"

export PATH="$PATH:~/Programming/llvm-project/_build/bin/"
export INFOPATH

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Overwrite locale settings, as they are somehow wrong
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"
export LANGUAGE="en_GB.UTF-8"

alias config="/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles"

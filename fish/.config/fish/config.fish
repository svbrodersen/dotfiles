if status is-interactive
    alias config='/usr/bin/lazygit --path ~/dotfiles/'
    set -gx EDITOR nvim

    set -gx BACKGROUND_COLOR "#141414"

    set -gx JAVA_HOME "/usr/lib/jvm/java-21-openjdk-21.0.5.0.11-1.fc41.x86_64"
    set -gx GOPATH "$HOME/local/go"
		set -gx XDG_CONFIG_HOME "$HOME/.config"
    fish_add_path -g "$GOPATH/bin"
    fish_add_path -g ~/.local/bin ~/.otherbin /usr/local/sbin ~/local/bin/
    fish_add_path -g ~/.cargo/bin/

    # Change keybindings
    bind \cY accept-autosuggestion
    bind \cP history-search-backward
    bind \cN history-search-backward

    #Zellij autocomplete
    eval (zellij setup --generate-completion fish | string collect)

    # Gitleaks autocomplete
    eval (gitleaks completion fish | string collect)

end

if status --is-login
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/simon/.ghcup/bin $PATH # ghcup-env

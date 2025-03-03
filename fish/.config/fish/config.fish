if status is-interactive
    #Zellij autocomplete
    eval (zellij setup --generate-completion fish | string collect)

    alias config='/usr/bin/lazygit --path ~/dotfiles/'
end

if status --is-login
    set -gx EDITOR nvim
    set -gx TERM wezterm

    # GOPATH
    set -gx GOPATH $HOME /local/go
    set -gx PATH $PATH "$GOPATH/local/go"

    set -gx JAVA_HOME "/usr/lib/jvm/java-21-openjdk-21.0.5.0.11-1.fc41.x86_64"
end

if status is-interactive
    
    # Alias
    alias speciale "zellij attach -c Speciale options --default-cwd /home/simon/Programming/MSc_cs/Speciale/"
    alias config='/usr/bin/lazygit --path ~/dotfiles/'

    # Variables
    set -gx EDITOR nvim
    set -gx BACKGROUND_COLOR "#111111"

    set -gx JAVA_HOME "/usr/lib/jvm/java-21-openjdk-21.0.5.0.11-1.fc41.x86_64"
    set -gx GOPATH "$HOME/local/go"
		set -gx XDG_CONFIG_HOME "$HOME/.config"
    fish_add_path -g "$GOPATH/bin"
    fish_add_path -g ~/.local/bin ~/.otherbin /usr/local/sbin ~/local/bin/
    fish_add_path -g ~/.cargo/bin/
    fish_add_path -g ~/.cabal/bin/

    # add cuda stuff
    fish_add_path -g /usr/local/cuda-13/bin/
    set -x CFLAGS "-I/usr/local/cuda-13/include"
    set -x LD_LIBRARY_PATH "/usr/local/cuda-13/lib64" $LD_LIBRARY_PATH
    set -x LIBRARY_PATH "/usr/local/cuda-13/lib64" $LIBRARY_PATH

    # Change keybindings
    bind \cY accept-autosuggestion
    bind \cP history-search-backward
    bind \cN history-search-backward

    # Zellij autocomplete
    if not set -q ZELLIJ_AUTOCONF_DONE
        eval (zellij setup --generate-completion fish | string collect)
        set -g ZELLIJ_AUTOCONF_DONE 1
    end

    # Gitleaks autocomplete
    if not set -q GIT_LEAKS_AUTOCONF_DONE
        eval (gitleaks completion fish | string collect)
        set -g GIT_LEAKS_AUTOCONF_DONE 1
    end


    # Haskell stuff
    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
    fish_add_path -g $HOME/.cabal/bin
    fish_add_path -g $HOME/.ghcup/bin


    # pnpm
    set -gx PNPM_HOME "/home/simon/.local/share/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
      set -gx PATH "$PNPM_HOME" $PATH
    end

    # opencode
    fish_add_path /home/simon/.opencode/bin

    # function fish_prompt
    #     # Prompt status only if it's not 0
    #     set -l last_status $status
    #     set -l stat
    #     if test $last_status -ne 0
    #         set stat (set_color red)"[$last_status]"(set_color normal)
    #     end
    #     set -g __fish_git_prompt_show_informative_status 1
    #     set -g __fish_git_prompt_showcolorhints 1
    #     set -g __fish_git_prompt_color purple
    #     set -g __fish_git_prompt_showupstream informative
    #
    #     string join '' -- (whoami) (set_color green) '@' (set_color red) (prompt_hostname) (set_color green) ":" (prompt_pwd) (set_color normal)  (fish_git_prompt)  \n $stat '> '
    # end


  set --global tide_pwd_color_anchors "normal"
  set --global tide_pwd_color_dirs "normal"
  set --global tide_pwd_color_truncated_dirs "normal"
  set --global tide_git_color_branch "purple"
end

if status --is-login
end



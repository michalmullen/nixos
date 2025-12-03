{ config, pkgs, ... }:

{
  # Shell tools configuration
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      cd = "z";
      ll = "ls -la";
      cat = "bat -p";
      vi = "nvim";
      lz = "lazygit";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoreboth" ];
    historySize = 1000;
    historyFileSize = 2000;
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];
    shellAliases = {
      # Navigation aliases
      cd = "z";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      
      # Color aliases
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      
      # Tool aliases
      cat = "bat -p";
      vi = "nvim";
      lz = "lazygit";
      
      # Custom aliases from .bash_aliases
      myonedrive = "no_proxy=graph.microsoft.com,deutscheboerse-my.sharepoint.com onedrive --synchronize";
    };
    sessionVariables = {
      HISTCONTROL = "ignoreboth";
      STARSHIP_CONFIG = "~/.config/starship/starship.toml";
      SDKMAN_DIR = "$HOME/.sdkman";
    };
    initExtra = ''
      # Color prompt setup
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      # Enable color support for directories
      if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      fi

      # Kubectl completion
      if command -v kubectl >/dev/null 2>&1; then
          source <(kubectl completion bash)
          complete -o default -F __start_kubectl k
      fi

      # SDKMAN initialization
      if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
          source "$HOME/.sdkman/bin/sdkman-init.sh"
      fi
    '';
  };

  # Session variables that apply to all shells
  home.sessionVariables = {
    XDG_DATA_DIRS = "/home/adrew/.nix-profile/share:$XDG_DATA_DIRS";
  };

  # Session path additions from .profile
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];

  # Force overwrite existing dotfiles
  home.file.".bashrc".force = true;
  home.file.".profile".force = true;
}

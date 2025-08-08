{ config, pkgs, ... }:
# let
#   nixvim = import (builtins.fetchGit {
#     url = "https://github.com/nix-community/nixvim";
#     # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
#     ref = "nixos-25.05";
#   });
#   home-manager = import <home-manager> {
#     configuration.nixpkgs = import <nixpkgs-unstable> {};
#   };
# in
{
  imports = [
    # Import the Home Manager module for Nixvim.
    # nixvim.homeModules.nixvim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "po252";
  home.homeDirectory = "/home/po252";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # terminal
    pkgs.hello
    pkgs.stow
    pkgs.pass
    pkgs.tmux
    pkgs.nushell
    pkgs.carapace
    pkgs.starship
    pkgs.zoxide
    pkgs.nnn
    pkgs.google-cloud-sdk
    pkgs.kubectl
    pkgs.kustomize
    pkgs.k9s
    pkgs.just
    pkgs.lazygit
    pkgs.bat
    pkgs.tdrop # bash -c 'tdrop -ma -w -4 -y "$PANEL_HEIGHT" -h 100% nixGLIntel alacritty'
    pkgs.gh
    pkgs.aichat
    pkgs.fzf

    # applications
    pkgs.alacritty
    pkgs.brave
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/adrew/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE=1;
    LIBGL_ALWAYS_SOFTWARE="1";
    FZF_DEFAULT_OPTS="--preview='bat --style=numbers,grid --color=always {}' --tmux";
  };

  programs.git = {
    enable = true;
    userName = "michalmullen";
    userEmail = "michalmullen@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = {
      core = {
        sshCommand = "ssh -o 'IdentitiesOnly=yes' -i ~/.ssh/id_ed25519";
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        args = ["new-session"  "-A"  "-D" "-s" "main"];
        program = "${pkgs.tmux}/bin/tmux";
      };
    };
    # theme = "tokyo_night";
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.pass
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.urlview
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
    ];

    extraConfig = ''
      set-option -g default-shell ${pkgs.nushell}/bin/nu
      set-option -g default-command "${pkgs.nushell}/bin/nu -i"
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g status-keys vi
      set -g mouse on

      set -g prefix C-Space
      bind C-Space send-prefix

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D 
      bind k select-pane -U
      bind l select-pane -R

      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Easy window splits
      bind | split-window -h
      bind _ split-window -v

      # double click and tripple click selection
      bind -T copy-mode    DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i"
      bind -T copy-mode-vi DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i"
      bind -n DoubleClick1Pane select-pane \; copy-mode -M \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i"
      bind -T copy-mode    TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i"
      bind -T copy-mode-vi TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i"
      bind -n TripleClick1Pane select-pane \; copy-mode -M \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i"

      # set vi-mode
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind % split-window -h -c "#{pane_current_path}"

      # copy with mouse
      set -g @yank_action 'copy-pipe-no-clear'

      set -g @plugin 'tmux-plugins/tmux-continuum'

      # Automatically save tmux sessions
      set -g @continuum-save-interval '15'

      # Automatically restore tmux sessions on tmux start
      set -g @continuum-restore 'on'
    '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = { 
    enable = true;
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

#   programs.nixvim = {
#     enable = true;
#     globals = {
#       mapleader = " ";
#       direnv_auto = 1;
#       direnv_silent_load = 0;
#     };
#     opts = {
#       number = true;         # Show line numbers
#       relativenumber = true; # Show relative line numbers
#       shiftwidth = 2;        # Tab width should be 2
#     };
#     plugins = {
#       trouble.enable = true;
#       bufferline.enable = true;
#       nvim-tree = {
#         enable = true;
#         openOnSetupFile = true;
#         autoReloadOnWrite = true;
#       };
#       gitsigns = {
#         enable = true;
#         settings = {
#           current_line_blame = true;
#           trouble = true;
#         };
#       };
#       treesitter = {
#         enable = true;
#         nixGrammars = true;
#         settings = {
#           highlight.enable = true;
#           indent.enable = true;
#         };
#       };
#       treesitter-context = {
#         enable = true;
#         settings = { max_lines = 2; };
#       };
#       rainbow-delimiters.enable = true;
#       lazygit = {
#         enable = true;
#       };
#       telescope = {
#         enable = true;
#         extensions.fzf-native = { enable = true; };
#       };
#     };
#     keymaps = [
#       # telescope
#       {
#         action = "<cmd>FZF<CR>";
#         key = "<leader>ff";
#       }
#       {
#         action = "<cmd>Telescope live_grep<CR>";
#         key = "<leader>fg";
#       }
#       {
#         action = "<cmd>Telescope buffers<CR>";
#         key = "<leader>fb";
#       }
#       {
#         action = "<cmd>Telescope help_tags<CR>";
#         key = "<leader>fh";
#       }
#     ];
#   };
    
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

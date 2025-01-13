{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "po252";
  home.homeDirectory = "/home/po252";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.git
    pkgs.dconf2nix
    pkgs.tmux
    pkgs.starship
  ];

  programs = {
    nushell = {
      enable = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {
    # Building this configuration will create a copy of 'dotfiles/screenrc' in the Nix store. Activating the configuration will then make '~/.screenrc' a symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    "~/.config/tmux/tmux.conf".source = dotfiles/tmux.conf;
    "~/.config/nushell/conf.nu".source = dotfiles/conf.nu;
    "~/.config/nushell/env.nu".source = dotfiles/env.nu;

    # You can also set the file content immediately.
    ".config/ghostty/config".text = ''
      theme = catppuccin-mocha
      font-size = 19
      background-blur-radius = 20
      mouse-hide-while-typing = true
      window-decoration = true
      keybind = global:cmd+/=toggle_quick_terminal
      macos-option-as-alt = true
      background-opacity = 0.7
      background-blur-radius = 20
    '';
  };

  # Home Manager can also manage your environment variables through 'home.sessionVariables'. If you don't want to manage your shell through Home Manager then you have to manually source 'hm-session-vars.sh' located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/michalmullen/etc/profile.d/hm-session-vars.sh

  home.sessionVariables = {
    NIX_CONFIG = "experimental-features = nix-command flakes";
  };

  programs.git = {
    enable = true;
    userName = "Andrew Mitchell Mullen";
    userEmail = "andrew.mitchell.mullen@deutsche-boerse.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

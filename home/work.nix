{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "po252";
  home.homeDirectory = "/home/po252";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    git
    tmux
    stow
    starship
    nushell
  ];

  programs = {
    nushell = {
      enable = true;
      configFile.source = ~/.config/nushell/config.nu;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
    };

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

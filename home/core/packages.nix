{ config, pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your environment
  home.packages = with pkgs; [
    # terminal
    kubernetes-helm
    stow
    pass
    tmux
    nushell
    carapace
    starship
    zoxide
    nnn
    google-cloud-sdk
    kubectl
    kustomize
    k9s
    just
    lazygit
    bat
    tdrop
    gh
    aichat
    fzf
    spotify
    temurin-bin-21
    mc

    # applications
    alacritty
    brave
    vscode
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    obsidian
    super-productivity
    postman
  ];

  # If you have Java configuration elsewhere, update it too:
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;  # Use stable OpenJDK instead
  };
}

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
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
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
    temurin-bin-21
    mc
    terraform
    openshift

    # applications
    postman
    vlc
  ];

  programs.browserpass.enable = true;

  # If you have Java configuration elsewhere, update it too:
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;  # Use stable OpenJDK instead
  };
}

{ config, pkgs, ... }:

{
  # Home Manager can manage your environment variables through 'home.sessionVariables'
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
    LIBGL_ALWAYS_SOFTWARE = "1";
    FZF_DEFAULT_OPTS = "--preview='bat --style=numbers,grid --color=always {}' --tmux";
  };
}

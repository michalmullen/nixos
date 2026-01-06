{ inputs, config, pkgs, vars, ... }:

{
  # Minimal home configuration for Framework with Omarchy
  # Omarchy provides: git, terminal (alacritty/kitty), shell config, tmux alternatives
  # We only import core settings and non-conflicting programs
  
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./core
    # Don't import ./programs to avoid conflicts with Omarchy
    # If you want specific programs, import them individually here
  ];
}

{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true; # bash -c 'tdrop -ma -w -4 -y "$PANEL_HEIGHT" -h 100% -t nixGLIntel ghostty'
    settings = {
      # Launch tmux session
      command = "tmux new-session -A -D -s main";

      # Optional: Remove the global keybind since tdrop will handle it
      # keybind = global:F12=toggle_quick_terminal;
    };
  };
}

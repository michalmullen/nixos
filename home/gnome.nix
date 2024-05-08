{ config, pkgs, inputs, ... }:

{  # https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      # to search for app name run the following:
      # dconf dump / | grep APP_NAME
      favorite-apps = ["firefox.desktop" "spotify.desktop" "anytype.desktop" "code.desktop" "thunderbird.desktop"];
    };
    "org/gnome/shell/extensions/hidetopbar" = {
      enable-active-window = false;
      enable-intellihide = false; 
    };
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      toolkit-accessibility = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = "disabled";
      toggle-message-tray = "disabled";
      close = ["<Super>q"];
      maximize = "disabled";
      minimize = ["<Super>comma"];
      move-to-monitor-down = "disabled";
      move-to-monitor-left = "disabled";
      move-to-monitor-right = "disabled";
      move-to-monitor-up = "disabled";
      move-to-workspace-down = "disabled";
      move-to-workspace-up = "disabled";
      toggle-maximized = ["<Super>m"];
      unmaximize = "disabled";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
      num-workspaces = 10;
    };
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
}
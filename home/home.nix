{ config, pkgs, pkgs-unstable, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "po252";
  home.homeDirectory = "/home/po252";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.git
    pkgs.dconf2nix
    pkgs.tmux
    pkgs.pass
    pkgs.nss
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
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
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
  #
  # sessionVariables = {
  #   # TODO: Not sure what the right way of doing this is...
  #   # The list of packages is a subset of `GI_TYPELIB_PATH` in `nix-shell -p gobject-introspection gtk4`.
  #   GI_TYPELIB_PATH = "$GI_TYPELIB_PATH:${pkgs.gobject-introspection.out}/lib/girepository-1.0:${pkgs.gtk4.out}/lib/girepository-1.0:${pkgs.graphene.out}/lib/girepository-1.0:${pkgs.gdk-pixbuf.out}/lib/girepository-1.0:${pkgs.harfbuzz.out}/lib/girepository-1.0:${pkgs.pango.out}/lib/girepository-1.0";
  #   LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.glib.out}/lib";
  # };

  home.file.passff-host-workaround = {
    target =
      "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/passff.json";
    source = "${pkgs.passff-host}/share/passff-host/passff.json";
  };

  programs.git = {
    enable = true;
    userName = "Mitchell Mullen";
    userEmail = "michalmullen@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

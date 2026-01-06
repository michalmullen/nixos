{ config, pkgs, pkgs-unstable, lib, ... }:

{
    # GnuPG
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = with pkgs; pinentry-gtk2;
        enableSSHSupport = true;
    };
}

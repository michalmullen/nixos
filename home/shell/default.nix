{ config, pkgs, vars, ... }:

let
  sharedShellAliases = {
    cd = "z";
    cat = "bat -p";
    vi = "nvim";
    lz = "lazygit";

    g = "git";
    ga = "git add";
    gb = "git branch";
    gc = "git commit";
    gco = "git checkout";
    gd = "git diff";
    gl = "git log --oneline --graph --decorate";
    gp = "git push";
    gst = "git status";
    gcl = "git clone";

    ghd = vars.aliases.ghb;
    oc-login-sit = "oc login --token=sha256~jSc7s5H4YmJUFV5p4vWY-mngaU1d7WgB3nLalJcN4V4 --server=https://api.g-sit-1.cool.dev.gcp.dbgcloud.io:6443";
    oc-login-dev = "oc login --token=sha256~jSc7s5H4YmJUFV5p4vWY-mngaU1d7WgB3nLalJcN4V4 --server=https://api.g-dev-1.cool.dev.gcp.dbgcloud.io:6443";
  };
in {
  imports = [
    ./git
    ./nixvim
    ./tmux
    ./carapace
    ./zoxide
    ./starship
    ./atuin
    ./nushell
    ./bash
  ];

  _module.args = { inherit sharedShellAliases; };
}
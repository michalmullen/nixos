{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = config.vars.username;
    userEmail = config.vars.email;
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = {
      core = {
        sshCommand = "ssh -o 'IdentitiesOnly=yes' -i ~/.ssh/id_ed25519";
      };
    };
  };
}

{ config, pkgs, vars, ... }:

{
  programs.git = {
    enable = true;
    userName = if vars.users.primary ? gitusername then vars.users.primary.gitusername else vars.users.primary.username;
    userEmail = vars.users.primary.email;
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

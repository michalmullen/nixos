{ config, pkgs, vars, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = if vars.users.primary ? gitusername then vars.users.primary.gitusername else vars.users.primary.username;
        email = vars.users.primary.email;
      };
      alias = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      core = {
        sshCommand = "ssh -o 'IdentitiesOnly=yes' -i ~/.ssh/id_ed25519";
      };
    };
  };
}

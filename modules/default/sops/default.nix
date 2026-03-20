{ vars, lib, ... }:
{
  # Use a dedicated GPG homedir on each machine for sops decryption.
  # This directory is populated once per machine during bootstrap
  # (see the setup commands in the feature/sops-secrets branch).
  sops.gnupg.home = "/var/lib/sops-gpg";
  sops.gnupg.sshKeyPaths = lib.mkForce [];

  sops.defaultSopsFile = ../../../secrets/ssh-key.yaml;

  sops.secrets.ssh_private_key = {
    owner = vars.users.primary.username;
    mode  = "0600";
    path  = "/home/${vars.users.primary.username}/.ssh/id_ed25519";
  };
}

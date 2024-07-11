# Nixos

My personal nixos config.

## Maintenance Commands

```bash
# to update packages
nix flake update 
# to apply changes (changes must be committed in git)
sudo nixos-rebuild switch --flake flake.nix#default
# to cleanup
nix-store --gc
# update dconf config 
# https://github.com/nix-community/dconf2nix
dconf dump / | dconf2nix > ./home/dconf.nix
```

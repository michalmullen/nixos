#!/usr/bin/env just --justfile

switch:
    sudo nixos-rebuild switch --flake flake.nix#$(hostname)

update:
    nix flake update

generations:
    nixos-rebuild list-generations

cleanup:
    nix-store --gc
    # sudo nix-collect-garbage -d
    # nix-store --verify --check-contents

# NixOS Configuration

Personal, flake-based NixOS configuration with integrated Home Manager support.

The configuration targets `x86_64-linux` and keeps shared system, user, shell, and application settings reusable across multiple hosts.

## Hosts

| Flake output | Hardware profile |
| --- | --- |
| `framework` | Framework Laptop 13 (AMD 7040 series) |
| `prodesk` | HP ProDesk |
| `desktop` | Desktop workstation |

Host-specific configuration lives under `hosts/<hostname>/`. Shared Home Manager configuration lives under `home/`.

## Prerequisites

- NixOS with flakes enabled
- Git
- [just](https://just.systems/)

Run commands from the repository root.

## Apply Configuration

The standard workflow detects the current hostname and activates its matching flake output:

```bash
just switch
```

Equivalent command:

```bash
sudo nixos-rebuild switch --flake ".#$(hostname)"
```

The hostname must match one of the outputs listed above. Home Manager is included as a NixOS module and is applied by the same rebuild.

## Validate Changes

Build a host configuration without activating it:

```bash
nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
```

To build the Framework configuration explicitly:

```bash
just remotly-test
```

Files referenced by the flake must be tracked by Git. They do not need to be committed, but untracked files are not included when evaluating a Git flake.

## Maintenance

| Command | Purpose |
| --- | --- |
| `just update` | Update all flake inputs and rewrite `flake.lock` |
| `just generations` | List available NixOS generations |
| `just cleanup` | Remove unreachable Nix store paths |

Review and build after updating dependencies:

```bash
just update
nix flake check
nix build ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
```

## Rollback

List previous generations:

```bash
just generations
```

Roll back to the previous generation:

```bash
sudo nixos-rebuild switch --rollback
```

## Repository Layout

| Path | Purpose |
| --- | --- |
| `hosts/` | Host-specific NixOS configuration |
| `home/` | Shared Home Manager configuration |
| `modules/` | Reusable NixOS modules |
| `lib/vars.nix` | Shared user and system values |
| `flake.nix` | Inputs and host output definitions |
| `flake.lock` | Pinned dependency revisions |
| `Justfile` | Common maintenance commands |

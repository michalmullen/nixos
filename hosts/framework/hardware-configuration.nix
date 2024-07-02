# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f682e3b4-61d9-4341-bc17-ed014634490d";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-4330116b-d33d-4eb2-a43a-bcfc8785d41a".device = "/dev/disk/by-uuid/4330116b-d33d-4eb2-a43a-bcfc8785d41a";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1485-7AFD";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a59d3116-7e64-4d0e-9f09-cd44863876cb"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/7040-amd
  hardware.framework.amd-7040.preventWakeOnAC = true;
  # hardware.enableRedistributableFirmware = true;
}

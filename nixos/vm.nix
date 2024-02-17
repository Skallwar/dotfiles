{ config, pkgs, lib, ... }:

{
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [ 
    virt-manager
    virtiofsd
    (pkgs.stdenv.mkDerivation {
      name = "virtiofsd-link";
      buildCommand = ''
        mkdir -p $out/bin
        ln -s ${pkgs.virtiofsd}/bin/virtiofsd $out/bin/
      '';
    })
  ];

  users.users.esteban.extraGroups = ["libvirtd"];
  # users.users.esteban.extraGroups = ["libvirtd" "user-with-access-to-virtualbox" ];
}

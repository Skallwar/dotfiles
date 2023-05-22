{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_wayland.url = "github:nix-community/nixpkgs-wayland";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    deploy-rs.url = "github:serokell/deploy-rs";
    sops-nix.url = github:Mic92/sops-nix;
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs_unstable,
    nixpkgs_wayland,
    nixos-hardware,
    deploy-rs,
    sops-nix,
  } @ inputs:
  let 
    unstable-overlay = final: prev: {
      syncthing = nixpkgs_unstable.legacyPackages.aarch64-linux.syncthing;
      autorandr = nixpkgs_unstable.legacyPackages.x86_64-linux.autorandr;
    };
  in {
    nixosConfigurations = {
      burritosblues = nixpkgs_unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s
          sops-nix.nixosModules.sops
          ./burritosblues/configuration.nix
          ./base.nix
          ./nix.nix
          ./desktop_apps.nix
          ./sound.nix
          ./fonts.nix
          ./yubikey-gpg.nix
          ./keychron.nix
          ./redshift.nix
          ./docker.nix
          ./vm.nix
          ./steam.nix
        ];
      };

      gusto = nixpkgs_unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./gusto/configuration.nix
          ./base.nix
          ./nix.nix
          ./desktop_apps.nix
          ./nvidia.nix
          ./g27q.nix
          ./sway.nix
          ./fonts.nix
          ./sound.nix
          ./yubikey-gpg.nix
          ./keychron.nix
          ./redshift.nix
          ./steam.nix
          {
            nixpkgs.overlays = [ nixpkgs_wayland.overlay ];
          }
        ];
      };

      nixpi = nixpkgs_unstable.lib.nixosSystem {
        system = "aarch64-linux";
        disabledModules = ["nixos/modules/services/hardware/throttled.nix"];
        modules = [
          ({ config, pkgs, ...}: { nixpkgs.overlays = [ unstable-overlay ]; })
          nixos-hardware.nixosModules.raspberry-pi-4
          # nixpkgs_custom.nixos.modules.services.hardware.throttled
          sops-nix.nixosModules.sops
          ./nixpi/configuration.nix
          # ./aarch64_cross.nix
          # {
          #   nixpkgs.buildPlatform.system = "x86_64-linux";
          #   nixpkgs.hostPlatform.system = "aarch64-linux";
          # }
        ];
      };
    };

    deploy.nodes = {
      burritosblues = {
        hostname = "localhost";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.burritosblues;
        };
      };

      nixpi = {
        hostname = "192.168.1.251";
        sshUser = "pi";
        sshOpts = ["-t"];
        magicRollback = false; # In order for sshOpts "-t" to work, see https://github.com/serokell/deploy-rs/issues/78#issuecomment-989069609
        # remoteBuild = true;
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.nixpi;
          # path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixpi;
        };
      };
    };

    # checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}

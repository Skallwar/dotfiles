{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    deploy-rs.url = "github:serokell/deploy-rs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs_unstable,
    # nixpkgs_wayland,
    nixos-hardware,
    deploy-rs,
    sops-nix,
  } @ inputs : rec {
    nixosConfigurations = {
      burritosblues = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # For having access to nixpkgs_unstable
          { _module.args = inputs; }
          ./unstable.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s
          sops-nix.nixosModules.sops
          ./burritosblues/configuration.nix
          ./base.nix
          ./i3.nix
          ./desktop_apps.nix
          ./sound.nix
          ./fonts.nix
          ./yubikey-gpg.nix
          ./keychron.nix
          #./redshift.nix
          ./docker.nix
          ./vm.nix
          ./steam.nix
          ./dev.nix
          ./boards.nix
          # ./d6000.nix
        ];
      };

      gusto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = inputs; }
          ./unstable.nix
          ./gusto/configuration.nix
          ./base.nix
          ./i3.nix
          ./desktop_apps.nix
          ./nvidia.nix
          ./g27q.nix
          # ./sway.nix
          ./fonts.nix
          ./sound.nix
          ./yubikey-gpg.nix
          ./keychron.nix
          ./redshift.nix
          ./steam.nix
          ./dev.nix
          {
            # nixpkgs.overlays = [ nixpkgs_wayland.overlay ];
          }
        ];
      };

      nixpi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs.flake-inputs = inputs;
        modules = [
          ({ config, pkgs, ...}: {
            nixpkgs.overlays = [ 
              (final: super: {
                zfs = super.zfs.overrideAttrs(_: {
                meta.platforms = [];
                });
              })
            ]; 
            nixpkgs.config.allowBroken = true;
          })
          # For having access to nixpkgs_unstable
          { _module.args = inputs; }
          nixos-hardware.nixosModules.raspberry-pi-4
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-new-kernel.nix"
          sops-nix.nixosModules.sops
          ./unstable.nix
          ./base.nix
          ./nixpi/configuration.nix
          ./home_assitant.nix
          ./vikunja.nix
          ./cli.nix
        ];
      };
    };

    images.nixpi = nixosConfigurations.nixpi.config.system.build.sdImage;

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

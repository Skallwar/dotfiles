{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs_wayland.url = "github:nix-community/nixpkgs-wayland/f3206bcb1f2eb6b36e60cba2640fc1897f3d2f3d";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    deploy-rs.url = "github:serokell/deploy-rs";
    sops-nix.url = github:Mic92/sops-nix;
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
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s
          sops-nix.nixosModules.sops
          ./burritosblues/configuration.nix
          ./base.nix
          ./nix.nix
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
          ./gusto/configuration.nix
          ./base.nix
          ./nix.nix
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
          nixos-hardware.nixosModules.raspberry-pi-4
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-new-kernel.nix"
          sops-nix.nixosModules.sops
          ./nixpi/configuration.nix
          ./home_assitant.nix
          ./vikunja.nix
          ./cli.nix
          {
            environment.noXlibs = false;
          }
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

{ config, pkgs, ... }:

{
  # Nix
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI
    neovim helix htop killall tree man-pages ncdu tmux ripgrep fd
    bash starship
    nix-output-monitor
  ];
}

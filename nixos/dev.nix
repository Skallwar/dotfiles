{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Debug
    gdb
    strace

    # Doc
    man-pages
    man-pages-posix

    # Tools
    fzf
    clang-tools
    gh
    glab
    gitFull
    # thefuck
    pay-respects
    aerc
    b4

    # Editor and LSP
    ruff
    pylyzer
    luajitPackages.lua-lsp
    clang-tools
    nixd

    # Network
    traceroute

    # Video stuff
    clinfo
    libva-utils
    vdpauinfo

    # When nixos is just too painfull
    distrobox
  ];

  programs.adb.enable = true;
  users.users.esteban.extraGroups = ["adbusers"];

  services.udev.packages = [ pkgs.openocd ];
}

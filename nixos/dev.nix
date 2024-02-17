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
    thefuck
    aerc
    b4

    # Editor and LSP
    ruff-lsp
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
  ];

  services.udev.packages = [ pkgs.openocd ];
}

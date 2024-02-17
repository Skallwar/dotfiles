with import <nixpkgs> {
  crossSystem = {
    config = "aarch64-unknown-linux-gnu";
    useLLVM = true;
  };
};

let
  python3-pkgs = buildPackages.python3.withPackages(p: with p; [
    ply
    GitPython
    yamllint
  ]);
in
mkShell {
  # NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
  # NIX_LD_x86_64-linux = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";

  depsBuildBuild = [ 
    buildPackages.stdenv.cc
    buildPackages.llvmPackages.bintools
    buildPackages.libllvm
    buildPackages.lld
    buildPackages.clang
  ];

  nativeBuildInputs = [
    autoconf
    automake
    bison
    flex
    bc
    ubootTools
    pkg-config
    openssl
    python3
    python3-pkgs
    perl
    codespell
    dtc
    ncurses
    python2
    rkdeveloptool
  ];

  # Env vars
  LLVM="1";
  ARCH="arm64";
}

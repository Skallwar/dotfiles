with import <nixpkgs> {
  crossSystem = {
    config = "aarch64-unknown-linux-gnu";
  };
};

let
  python3-pkgs = buildPackages.python3.withPackages(p: with p; [
    ply
    GitPython
    yamllint
    setuptools
    pyelftools
  ]);
in
mkShell {
  depsBuildBuild = [ 
    buildPackages.stdenv.cc
  ];

  nativeBuildInputs = [
    buildPackages.autoconf
    buildPackages.automake
    buildPackages.bison
    buildPackages.flex
    buildPackages.bc
    buildPackages.pkg-config
    buildPackages.openssl
    buildPackages.perl
    buildPackages.codespell
    buildPackages.dtc
    buildPackages.ncurses
    buildPackages.python2
    buildPackages.rkdeveloptool
    buildPackages.pkg-config
    buildPackages.parted

    # U-boot
    buildPackages.ubootTools
    buildPackages.swig
  ];

  packages = [
    (python3-pkgs)
  ];

  # Env vars
  ARCH="arm64";
  CROSS_COMPILE="aarch64-unknown-linux-gnu-";
  PKG_CONFIG_PATH="${pkgs.ncurses.dev}/lib/pkgconfig";
}

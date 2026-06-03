{ stdenv, buildUBoot, fetchFromGitHub, armTrustedFirmwareRK3588, rkbin, ...}:

(buildUBoot rec {
  version = "v2025.10";
  src = fetchFromGitHub {
    owner = "Skallwar";
    repo = "u-boot";
    # Linux patch
    # rev = "6b42999787b27ad7a40b8598cb2282df69356b1f";
    # sha256 = "sha256-IIPp/HmSSbARdJInjGw7BTw9nSL8l2FO9NSW9UBXof4=";

    # Linux patch + debug = err
    rev = "e7ced46d61561492d3e0e91f303d3cb3b944a690";
    sha256 = "sha256-GRACWeiwUe7Js6mzf6avhHaSDs09B0k4IBmKLr/is8A=";
  };
  defconfig = "rock5b-rk3588_defconfig";
  extraMeta.platforms = [ "aarch64-linux" ];
  env = {
    BL31 = "${armTrustedFirmwareRK3588}/bl31.elf";
    ROCKCHIP_TPL = rkbin.TPL_RK3588;
  };
  filesToInstall = [
    "u-boot.itb"
    "idbloader.img"
    "u-boot-rockchip.bin"
    "u-boot-rockchip-spi.bin"
  ];
  extraConfig = ''
    CONFIG_LOG=y
    CONFIG_LOG_CONSOLE=y
  '';
    # CONFIG_LOG_MAX_LEVEL=7
    # CONFIG_LOGLEVEL=7
})


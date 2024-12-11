{ config, pkgs, ... }:

{
  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull; # More codec like LDAC
  #   support32Bit = true; ## For 32-bit app support
  # };
  # nixpkgs.config.pulseaudio = true;

  ## Pipewire disabled for now, robotic voices
  # security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}

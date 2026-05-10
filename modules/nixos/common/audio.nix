# PipeWire-based audio with PulseAudio compatibility layer.
_: {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # needed for 32-bit games via Steam/Wine
    pulse.enable = true; # PulseAudio compat shim
  };
}

{
  pkgs,
  config,
  username,
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    (import ../../modules/system.nix { inherit pkgs username; })
    ../../modules/wm/kde.nix
  ];

  networking.hostName = hostname;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  services = {
    xserver = {
      # Configure keymap in X11
      xkb = {
        layout = "br";
        variant = "";
      };
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
  };

  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;

      # Open Source Kernel Modules
      open = true;

      # Beta Drivers
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # ZRam
  zramSwap.enable = true;

  # Swap File
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];
}

{ pkgs, ... }:

let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ./.;
    dontUnpack = true;
    installPhase = ''
      cp $src/wallpaper.png $out
    '';
  };
  theme = "breeze";
in
{
  services = {
    displayManager.sddm = {
      inherit theme;
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/${theme}/theme.conf.user" ''
      [General]
      background = ${background-package}
    '')
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];
}

{ pkgs, ... }:

{
  home = {
    username = "luna";
    homeDirectory = "/home/luna";

    stateVersion = "24.05";

    packages = with pkgs; [
      home-manager
      firefox
      vesktop
      vscode
      prismlauncher
      vlc
      qbittorrent
      direnv
      nix-direnv
      heroic
      rustup
      gcc
      nil
    ];
  };

  programs.bash.historyControl = [
    "ignoredups"
    "ignorespace"
  ];
}

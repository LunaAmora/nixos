{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./vscode.nix
    ./git.nix
    # ./rust.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      home-manager
      nil
      nh
      firefox
      discord
      vlc
      qbittorrent
      kdePackages.filelight
    ];

    sessionVariables.NH_FLAKE = "/etc/nixos";
  };

  programs.bash = {
    enable = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
  };
}

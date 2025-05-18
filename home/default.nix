{ pkgs, username, ... }:

{
  imports = [
    ./vscode.nix
    ./git.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      home-manager
      firefox
      discord
      vlc
      qbittorrent
      nil
      kdePackages.filelight
      etterna
      nh
      mold
      clang
      rustup
    ];

    sessionVariables.NH_FLAKE = "/etc/nixos";

    file.".cargo/config.toml".text = ''
      [target.x86_64-unknown-linux-gnu]
      linker = "clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
    '';
  };

  programs.bash = {
    enable = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
  };
}

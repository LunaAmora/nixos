{pkgs, ...}: {
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
      ];
    };
  };

  home = {
    packages = with pkgs; [
      jetbrains-toolbox
      prismlauncher
      ripgrep
    ];
  };
}

{pkgs, ...}: {

  home = {
    packages = with pkgs; [
      jetbrains-toolbox
      prismlauncher
      ripgrep
    ];
  };
}

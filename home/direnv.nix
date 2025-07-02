{pkgs, ...}: {
  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(direnv hook bash)"
        export DIRENV_LOG_FORMAT=
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };

    vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
    ];
  };
}

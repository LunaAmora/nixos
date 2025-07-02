{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      userName = "LunaAmora";
      userEmail = "luna.mberry@gmail.com";
      extraConfig.merge.conflictStyle = "diff3";
    };

    vscode.profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens
      ];

      userSettings = {
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        "gitlens.views.scm.grouped.views" = {
          "commits" = true;
          "branches" = true;
          "remotes" = true;
          "stashes" = false;
          "tags" = true;
          "worktrees" = true;
          "contributors" = true;
          "repositories" = false;
          "searchAndCompare" = false;
          "launchpad" = false;
        };

        "gitlens.plusFeatures.enabled" = false;
        "gitlens.codeLens.enabled" = false;
      };
    };
  };
}

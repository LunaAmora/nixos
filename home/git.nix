{ ... }:

{
  programs.git = {
    enable = true;
    userName = "LunaAmora";
    userEmail = "luna.mberry@gmail.com";
    extraConfig.merge.conflictStyle = "diff3";
  };
}

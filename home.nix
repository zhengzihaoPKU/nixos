{config, pkgs, ...}:

{
  home.username = "zihao";
  home.homeDirectory = "/home/zihao";

  programs.git = {
    enable = true;
    userName = "zhengzihaoPKU";
    userEmail = "zhengzihao@stu.pku.edu.cn";
  };
  home.stateVersion = "25.11";
}


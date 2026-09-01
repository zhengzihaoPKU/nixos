{ pkgs, ... }:

{
  users.groups.clash-verge.members = [ "zihao" ];

  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    autoStart = true;
    serviceMode = true;
    tunMode = true;
    group = "clash-verge";
  };
}

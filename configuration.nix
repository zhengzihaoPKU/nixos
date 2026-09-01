{ pkgs, ... }:

{
  # 网络；主机名放在每台设备自己的 host-configuration.nix 中。
  networking.networkmanager.enable = true;

  # 时区与中文支持
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true;
  };

  # 国内加速（永久生效）
  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"     # 中科大（可优先）
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"  # 清华
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  # 用户密码不进入 Nix store 或 Git；安装后使用 passwd 设置。
  users.users.zihao = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # 基本软件包
  environment.systemPackages = with pkgs; [
    vim git wget curl tree which fastfetch
    python313
  ];

  services.openssh.enable = true;

  # 首次安装时的兼容基线；不要在升级 nixpkgs 时随意修改。
  system.stateVersion = "26.05";
}

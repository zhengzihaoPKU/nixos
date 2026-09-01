{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Keep GDM as the login screen, but start Niri instead of GNOME Shell.
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "niri";

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    fuzzel
    swaylock
    wl-clipboard
    xwayland-satellite
    polkit_gnome
  ];

  systemd.user.services.niri-polkit-agent = {
    description = "Polkit authentication agent for Niri";
    wantedBy = [ "niri.service" ];
    partOf = [ "niri.service" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };
}

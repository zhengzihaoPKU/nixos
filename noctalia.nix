{ pkgs, inputs, ... }:

let
  noctaliaPackage =
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  # Services used by Noctalia's status and control widgets.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  home-manager.users.zihao = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia-shell = {
      enable = true;
      settings.bar = {
        position = "top";
        density = "compact";
      };
    };

    # Niri starts XDG autostart entries inside its graphical session, giving
    # Noctalia the correct Wayland and IPC environment without a standalone
    # long-running systemd service.
    xdg.configFile."autostart/noctalia-shell.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Noctalia Shell
      Exec=${noctaliaPackage}/bin/noctalia-shell
      OnlyShowIn=niri;
      NoDisplay=true
      X-GNOME-Autostart-enabled=true
    '';
  };
}

{
  description = "zzh's NixOS Configuration";

  inputs = {
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
     # rust-overlay.url = "github:oxalica/rust-overlay";
     # wezterm.url = "github:wez/wezterm?dir=nix";
     # nix-ai-tools.url = "github:numtide/nix-ai-tools";
     noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    }; 
 };

  outputs = {self, nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # systems = [ "aarch64-linux" ];
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./programming-language.nix
	./gc.nix
	# ./gnome.nix
        # ./open-ssh.nix
        ./nixpkgs.nix
	./firewall.nix
        ./hyprland.nix
	./nix-settings.nix
	# ./noctalia.nix
	./cpp-toolchain.nix
        # ./cuda-toolchain.nix
	./fish-shell.nix
      ];
    };
  };
}

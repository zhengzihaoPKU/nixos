{
  description = "XNM's NixOS Configuration";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      # rust-overlay.url = "github:oxalica/rust-overlay";
      # wezterm.url = "github:wez/wezterm?dir=nix";
      # nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./programming-language.nix
	./gc.nix
      ];
    };
  };
}

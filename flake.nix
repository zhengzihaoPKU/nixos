{
  description = "zzh's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    # This module is hardware-independent and can be imported by another flake.
    portableModule = { ... }: {
      _module.args.inputs = inputs;
      imports = [
        ./configuration.nix
        ./programming-language.nix
        ./gc.nix
        ./gnome.nix
        ./nixpkgs.nix
        ./firewall.nix
        ./nix-settings.nix
        ./cpp-toolchain.nix
        ./fish-shell.nix
        ./noctalia.nix
        home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.zihao = import ./home.nix;
        extraSpecialArgs = { inherit inputs; };
      };
    };

    # These files are generated/created separately on every machine. Because
    # they are gitignored, use `--flake path:.#nixos` when rebuilding.
    hasLocalConfiguration =
      builtins.pathExists ./hardware-configuration.nix
      && builtins.pathExists ./host-configuration.nix;
  in
  {
    nixosModules.default = portableModule;

    nixosConfigurations = nixpkgs.lib.optionalAttrs hasLocalConfiguration {
      nixos = nixpkgs.lib.nixosSystem {
        modules = [
          portableModule
          ./hardware-configuration.nix
          ./host-configuration.nix
        ];
      };
    };
  };
}

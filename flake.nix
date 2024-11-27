{
  description = "LunaAmora System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    { nixpkgs, nix-flatpak, ... }:
    {
      nixosConfigurations.dell-g15 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./hosts/dell-g15
        ];
      };
    };
}

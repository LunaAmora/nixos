{
  description = "LunaAmora System Configuration Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {self, nixpkgs, ...}@inputs: {
    nixosConfigurations.dell-g15 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/dell-g15
      ];
    };
  };
}
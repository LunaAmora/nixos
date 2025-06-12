{
  description = "LunaAmora System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    alejandra,
    ...
  }: let
    username = "luna";
    hostname = "dell-g15";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./hosts/${hostname}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs.username = username;
          home-manager.users.${username} = import ./home;
        }

        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
      ];
      specialArgs = {
        inherit username hostname;
      };
    };
  };
}

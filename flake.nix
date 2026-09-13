{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.badblood = nixpkgs.lib.nixosSystem {

      system = "x86_64-linux";

     specialArgs = { inherit inputs; };

      modules = [ ./configuration.nix ];
    };
  };
}
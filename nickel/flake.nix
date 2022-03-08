# Use simply with: `nix shell .` to get a shell with nickel at the locked version
{
  inputs.nickel.url = "github:tweag/nickel";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, nickel }:
  let
    sys = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${sys};
  in {
    defaultPackage = nickel.defaultPackage;
  };
}

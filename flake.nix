{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
    esp32-dev.url = "github:mirrexagon/nixpkgs-esp-dev";
  };

  outputs = { self, nixpkgs, flake-utils, esp32-dev }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default =
        pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt
            nixpkgs-fmt
            python310Packages.pip
          ] ++ esp32-dev.devShells.${system}.esp-idf-full.buildInputs;
        };
    };
}

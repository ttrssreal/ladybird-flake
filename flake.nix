{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    git-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-environments.url = "github:nix-community/nix-environments";
    nix-environments.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      flake-parts,
      git-hooks-nix,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        git-hooks-nix.flakeModule
        treefmt-nix.flakeModule
      ];

      transposition.nix-environments = { };

      perSystem =
        {
          config,
          inputs',
          ...
        }:
        {
          pre-commit = {
            check.enable = true;
            settings.hooks = {
              treefmt.enable = true;
              nixfmt-rfc-style.enable = true;
            };
          };

          treefmt.programs.nixfmt.enable = true;

          devShells.default = inputs'.nix-environments.devShells.ladybird.overrideAttrs (
            final: prev: {
              shellHook =
                prev.shellHook
                + ''
                  ${config.pre-commit.installationScript}
                '';
            }
          );
        };

      systems = [
        "x86_64-linux"
      ];
    };
}

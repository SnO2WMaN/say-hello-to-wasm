{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
    flake-utils,
    devshell,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlay
            rust-overlay.overlays.default
          ];
        };
      in {
        devShell = pkgs.devshell.mkShell {
          imports = [
            (pkgs.devshell.importTOML ./devshell.toml)
          ];
          packages = with pkgs; [
            # https://gist.github.com/573/885a062ca49d2db355c22004cc395066?permalink_comment_id=3922859#gistcomment-3922859
            (rust-bin.stable.latest.default.override {
              extensions = ["rust-src"];
              targets = ["wasm32-unknown-unknown"];
            })
          ];
        };
      }
    );
}

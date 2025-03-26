# default.nix
# The main nix script
# Tuto: https://nix.dev/guides/recipes/sharing-dependencies
let
  # <nixpkgs> refers to the nixpkgs channel
  pkgs = import <nixpkgs> { config = {}; overlays = []; };
  # 2.7.1 for semantic release https://semantic-release.gitbook.io/semantic-release/support/git-version
  # 2.9.0 for hooks https://stackoverflow.com/questions/39332407/git-hooks-applying-git-config-core-hookspath
  gitMinVersion = "2.9.0";
  helloworld = pkgs.callPackage ./build.nix { go = pkgs.go_1_23; };
in

assert pkgs.lib.versionAtLeast pkgs.git.version gitMinVersion || throw "Git version ${pkgs.git.version} is less than required minimum ${gitMinVersion} for git hooks";

# Returned object
{

  # Create a helloworld
  # that you can run with nix-build -A helloworld
  inherit helloworld;
  # Create a shell function (used in shell.nix)
  shell = pkgs.mkShellNoCC {
      packages = with pkgs; [
        git
        git-cliff
        goreleaser
        jreleaser-cli
        go-task
        nodejs
        nodePackages."@commitlint/cli"
        nodePackages."@commitlint/config-conventional"
      ];
      # Take the package’s dependencies (go) into the environment with inputsFrom
      inputsFrom = [ helloworld ];
      shellHook = ''
          echo "Hallo from Nix. Build Tools:"
          echo "Git Version        : $(git --version)"
          echo "Go Version         : $(go version)"
          '';

     };
}
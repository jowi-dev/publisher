{
  description = "Elixir Project for command line actions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          packageName = "emporium";
          docPath="";
          basePackages = with pkgs; [
            beam.interpreters.elixir
            elixir 
            erlang_27
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [inotify-tools] ;

          erl = pkgs.beam.interpreters.erlang_27;
          erlangPackages = pkgs.beam.packagesWith erl;

            
          hooks = ''
            # this allows mix to work on the local directory
            mkdir -p .nix-mix .nix-hex
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.nix-hex
            export PATH=$MIX_HOME/bin:$MIX_HOME/escripts:$HEX_HOME/bin:$PATH

            mix local.hex --if-missing
            export LANG=en_US.UTF-8
            export ERL_AFLAGS="-kernel shell_history enabled"
          '';
        in
        {
          devShells.default = pkgs.mkShell {
            packages = basePackages;
            shellHook = hooks;
          };

          packages.default =   erlangPackages.mixRelease {
            version = "0.1.0";
            src=./.;
            pname = "emporium";
            mixFodDeps = erlangPackages.fetchMixDeps {
              version = "0.1.0";
              src = ./.;
              pname = "emporium-deps";
              sha256 = "sha256-EeDWBGrd77eRWVwtIGqHvvMKBqm5F78eZ7/MGlQl8Go=";
            };
            postBuild = ''
              mix escript.build
            '';
            installPhase = ''
              mkdir -p $out/bin
              mv ${packageName} $out/bin/${packageName}
            '';
          };
        };
    };
}

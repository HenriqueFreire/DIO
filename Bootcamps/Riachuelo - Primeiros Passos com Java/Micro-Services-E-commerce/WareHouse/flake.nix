{
  description = "Flake for the WareHouse service";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Fixed-output derivation for Gradle dependencies
        gradleDeps = pkgs.runCommand "warehouse-gradle-deps" {
          src = ./.;
          buildInputs = [ pkgs.gradle pkgs.jdk21 ];
          outputHashAlgo = "sha256";
          outputHashMode = "recursive";
          outputHash = "sha256-WunIEuTEYCgDAU86UIGwXcqge34Fq+lblSzFd8TgzHs=";
        } ''
          cp -r $src/* ./
          chmod +x ./gradlew
          export GRADLE_USER_HOME=$(mktemp -d)
          ./gradlew dependencies compileJava bootJar
          mkdir -p $out
          cp -r $GRADLE_USER_HOME/caches $out/
          cp -r $GRADLE_USER_HOME/notifications $out/
          cp -r $GRADLE_USER_HOME/wrapper $out/
        '';

        # Gradle build configuration
        gradleBuild = pkgs.stdenv.mkDerivation {
          name = "warehouse-build";
          src = ./.;
          buildInputs = [ pkgs.gradle pkgs.jdk21 ];
          buildPhase = ''
            chmod +x ./gradlew
            export GRADLE_USER_HOME=$(mktemp -d)
            cp -r ${gradleDeps}/* $GRADLE_USER_HOME/
            chmod -R +w $GRADLE_USER_HOME
            ./gradlew build -x test --offline
          '';
          installPhase = ''
            mkdir -p $out/libs
            cp build/libs/warehouse-0.0.1-SNAPSHOT.jar $out/libs/app.jar
          '';
        };

        # Docker image configuration
        dockerImage = pkgs.dockerTools.buildImage {
          name = "warehouse";
          tag = "latest";
          copyToRoot = pkgs.buildEnv {
            name = "image-root";
            paths = [ gradleBuild ];
          };
          config = {
            Cmd = [ "${pkgs.jdk21}/bin/java" "-jar" "/libs/app.jar" ];
            ExposedPorts = { "8080/tcp" = {}; };
          };
        };
      in
      {
        packages = {
          inherit dockerImage;
          default = dockerImage;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            jdk21
            gradle
            docker
            docker-compose
            cacert
          ];
          shellHook = ''
            export JAVA_HOME="${pkgs.jdk21.home}"
          '';
        };
      });
}

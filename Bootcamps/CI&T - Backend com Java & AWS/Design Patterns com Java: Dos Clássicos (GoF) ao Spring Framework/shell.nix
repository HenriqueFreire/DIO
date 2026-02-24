{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk17
    maven
  ];

  shellHook = ''
    echo "Welcome to the Spring Boot development environment!"
    echo "Java version: $(java -version)"
    echo "Maven version: $(mvn -v)"
  '';
}
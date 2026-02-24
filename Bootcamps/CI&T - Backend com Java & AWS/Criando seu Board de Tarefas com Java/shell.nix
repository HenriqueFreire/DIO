with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "java-gradle-shell";
  buildInputs = [
    jdk17
    gradle
  ];
}
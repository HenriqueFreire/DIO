with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "bitcoin-key-gen-env";
  buildInputs = [
    gcc # C++ compilador (inclui o g++)
    secp256k1 # Para operações de curva elíptica
  ];
}
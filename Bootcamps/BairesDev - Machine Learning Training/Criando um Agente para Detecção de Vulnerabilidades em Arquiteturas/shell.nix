{ pkgs ? import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f.tar.gz";
}) {} }:

let
  # Define um ambiente Python com pacotes específicos do Nix
  pythonEnv = pkgs.python312.withPackages (ps: with ps; [
    # Adicione outros pacotes python aqui
    fastapi
    openai
    uvicorn
    python-dotenv
    python-multipart
  ]);
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    # O ambiente Python com tudo já instalado
    pythonEnv

    # Dependências de sistema para os pacotes Python
  ];

  shellHook = ''
    unset SOURCE_DATE_EPOCH
    echo "Ambiente Nix (puro) carregado."
    echo "As bibliotecas Python já estão disponíveis."
  '';
}

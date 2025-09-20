{ pkgs ? import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/e6f23dc08d3624daab7094b701aa3954923c6bbb.tar.gz";
}) {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    #pkgs.python311Packages.pip
  ];

  shellHook = ''
    echo "Bem-vindo ao ambiente de desenvolvimento do gerador de testes!"
    # Create a virtual environment to keep python packages isolated
    if [ ! -d ".venv" ]; then
      python -m venv .venv
    fi
    source .venv/bin/activate
    # Install dependencies if requirements.txt exists
    if [ -f "requirements.txt" ]; then
      pip install -r requirements.txt
    fi
    echo "Ambiente ativado. Use 'exit' para sair."
  '';
}

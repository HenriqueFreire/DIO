{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/63dde259203998378d3f6655c65f299166f21226.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python312Full
    pkgs.python312Packages.pip
    pkgs.python312Packages.virtualenv
    pkgs.terraform
    pkgs.azure-cli
  ];

  shellHook = ''
    if [ ! -d .venv ]; then
      python -m venv .venv
    fi
    source .venv/bin/activate
    pip install azure-ai-ml azure-identity openai langchain-openai pypdf python-dotenv
    echo "Ambiente pronto para o Chatbot com Azure AI Foundry!"
    echo "Execute 'terraform init' dentro da pasta 'terraform' para começar."
  '';
}

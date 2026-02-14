{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/50ab793786d9de88ee30ec4e4c24fb4236fc2674.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.python312.withPackages (ps: with ps; [
      requests
      beautifulsoup4
      python-dotenv
      pip
    ]))
  ];

  shellHook = ''
    echo "Ambiente de Tradução Azure AI carregado!"
    echo "Python version: $(python --version)"
    
    # Se precisarmos instalar algo via pip que não está no nixpkgs:
    if [ ! -d ".venv" ]; then
      python -m venv .venv
    fi
    source .venv/bin/activate
    
    # O azure-ai-translation-text pode ser instalado via pip se não estiver no nixpkgs
    # pip install azure-ai-translation-text --quiet
  '';
}

{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/63dde259203998378d3f6655c65f299166f21226.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    azure-cli
    terraform
    python312Packages.python
    python312Packages.pip
    python312Packages.pandas
    python312Packages.scikit-learn
    python312Packages.matplotlib
    python312Packages.numpy
    docker
  ];

  shellHook = ''
    echo "Azure ML Automation Environment Loaded!"
    echo "Dica: Use 'pip install azure-ai-ml' se precisar do SDK dentro deste shell."
    echo "Python version: $(python --version)"
    echo "Terraform version: $(terraform version)"
    echo "Azure CLI version: $(az --version | head -n 1)"
  '';
}

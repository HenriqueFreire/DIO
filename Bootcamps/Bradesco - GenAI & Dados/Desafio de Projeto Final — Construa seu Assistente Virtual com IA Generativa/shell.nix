{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    (python3.withPackages (p: with p; [
      python-dotenv
      requests
      google-generativeai
      # brapi - Assuming brapi is not in nixpkgs, will install via pip if necessary
    ]))
  ];

  # Set PYTHONPATH to include packages installed in the user environment
  shellHook = ''
    export PYTHONPATH="$PWD/.venv/lib/python3.10/site-packages:$PYTHONPATH"
    echo "Nix shell entered. Python environment configured."
  '';
}
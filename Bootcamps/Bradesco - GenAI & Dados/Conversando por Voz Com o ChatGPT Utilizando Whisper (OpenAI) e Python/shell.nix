{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Python environment for the backend
  buildInputs = with pkgs; [
    python3
    nodejs
    yarn # React Native often uses yarn
    watchman
    pkgs.python3Packages.pytest # For running Python tests
    pkgs.python3Packages.httpx # For TestClient in FastAPI
    pkgs.python3Packages.fastapi
    pkgs.python3Packages.uvicorn
    pkgs.python3Packages.openai
    pkgs.python3Packages.gtts
    pkgs.python3Packages.speechrecognition
    pkgs.python3Packages.python-multipart # Required by FastAPI for form data (UploadFile)
  ];

  # Allow unfree packages, necessary for some React Native dependencies like Flipper
  allowUnfree = true;

  # Python environment setup - simplified as core python packages are in buildInputs
  shellHook = ''
    # Node.js and React Native environment setup
    export NIX_PATH="nixpkgs=${pkgs.path}"
    export PYTHONPATH="$PWD:$PYTHONPATH"
    export PATH="$PWD/node_modules/.bin:$PATH"
    echo "Development environment for Python and React Native is ready."
  '';
}

{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python312.withPackages (ps: with ps; [
    fastapi
    uvicorn
    sqlalchemy
    pydantic
    pytest
    httpx
    python-multipart
    pyttsx3
    spacy
    language-tool-python
    openai-whisper
  ]);
in
pkgs.mkShell {
  buildInputs = [
    pythonEnv
    pkgs.sqlite
    pkgs.espeak-ng
    pkgs.ffmpeg
    pkgs.jdk
    pkgs.nodejs_20
    pkgs.yarn
  ];

  shellHook = ''
    echo "LingoLocal Backend Development Environment"
    export PYTHONPATH=$PYTHONPATH:$(pwd)/backend
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ 
      pkgs.espeak-ng 
      pkgs.stdenv.cc.cc.lib 
      pkgs.zlib
    ]}:$LD_LIBRARY_PATH
  '';
}

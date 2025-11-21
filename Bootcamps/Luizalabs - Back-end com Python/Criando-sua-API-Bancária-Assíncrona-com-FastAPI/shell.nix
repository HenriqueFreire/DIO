{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    (python311.withPackages (ps: with ps; [
      fastapi
      uvicorn
      databases
      aiosqlite
      asyncpg
      pyjwt
      psycopg2-binary
      pydantic-settings
      alembic
    ]))
    poetry
  ];
}

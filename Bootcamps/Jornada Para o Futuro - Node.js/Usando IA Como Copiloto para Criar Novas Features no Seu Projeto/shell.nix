with import <nixpkgs> {};

pkgs.mkShell {
  name = "forum-api-env";
  buildInputs = [
    pkgs.nodejs
    pkgs.typescript
  ];
}

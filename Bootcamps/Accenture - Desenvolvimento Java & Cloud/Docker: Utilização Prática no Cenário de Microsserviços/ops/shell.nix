{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    drogon
    postgresql
    nginx
    # Adicione outras ferramentas de desenvolvimento aqui, ex: git, cmake, etc.
  ];

  shellHook = ''
    echo "Bem-vindo ao ambiente de desenvolvimento Drogon!"
    # Você pode adicionar comandos shell personalizados aqui
  '';
}

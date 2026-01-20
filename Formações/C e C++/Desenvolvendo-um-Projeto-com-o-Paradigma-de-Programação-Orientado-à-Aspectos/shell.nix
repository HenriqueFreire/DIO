{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Pacotes que estarão disponíveis no ambiente
  buildInputs = [
    pkgs.jdk11  # Java Development Kit versão 11
    pkgs.maven  # Ferramenta de automação de compilação Maven
  ];

  # Comando executado ao entrar no shell
  shellHook = ''
    echo "Ambiente de desenvolvimento Java e Maven pronto."
    echo "-------------------------------------------------"
    echo "Versão do Java:"
    java -version
    echo "-------------------------------------------------"
    echo "Versão do Maven:"
    mvn -v
    echo "-------------------------------------------------"
  '';
}

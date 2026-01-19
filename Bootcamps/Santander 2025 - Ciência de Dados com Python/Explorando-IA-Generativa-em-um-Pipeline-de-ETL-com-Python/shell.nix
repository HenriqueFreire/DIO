{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Pacotes do sistema que estarão disponíveis no shell
  buildInputs = with pkgs; [
    # Define a versão do Python e os pacotes a serem instalados
    (python311.withPackages (ps: with ps; [
      pandas
      openai
    ]))
  ];

  shellHook = ''
    echo "Bem-vindo ao ambiente de desenvolvimento Python!"
    echo "Python com pandas e openai está pronto para uso."
    echo ""
    echo "Lembre-se de configurar sua chave de API antes de executar o script:"
    echo "export OPENAI_API_KEY='sua_chave_aqui'"
    echo ""
    echo "Para iniciar o ambiente, execute 'nix-shell' no seu terminal."
    echo "Para sair, digite 'exit'."
  '';
}

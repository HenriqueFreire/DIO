{ pkgs ? import (fetchTarball {
  # Commit fixo do Nixpkgs para garantir reprodutibilidade
  url = "https://github.com/NixOS/nixpkgs/archive/f098c1634d7bc427d9fe51e5f536c8aed65c1991.tar.gz";
}) {} }:

pkgs.mkShell {
  # Dependências do ambiente Python para o projeto de busca de imagens
  buildInputs = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.gcc # Adiciona o compilador GCC e suas bibliotecas de runtime
  ];

  # Hook opcional ao entrar no shell
  shellHook = ''
    echo "Python versão: $(python --version)"
    # Define o diretório do ambiente virtual                                                                                                                
     VENV_DIR=".venv"                                                                                                                                 
                                                                                                                                                        
       # Cria o ambiente virtual se ele não existir                                                                                                     
       if [ ! -d "$VENV_DIR" ]; then                                                                                                                    
         echo "Criando ambiente virtual em $VENV_DIR..."                                                                                                
         python -m venv "$VENV_DIR"                                                                                                                     
       fi                                                                                                                                               
                                                                                                                                                        
       # Ativa o ambiente virtual                                                                                                                       
       source "$VENV_DIR/bin/activate"                                                                                                                  
                                                                                                                                                        
       echo "Ambiente virtual ativado. Use 'pip install -r requirements.txt' para instalar as dependências."
  '';
}
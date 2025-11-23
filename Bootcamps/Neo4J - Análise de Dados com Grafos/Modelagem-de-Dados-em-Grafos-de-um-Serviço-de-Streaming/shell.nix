{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  neo4j-pkg = pkgs.neo4j;
  neo4j-version = "5.26.1"; # Ajuste para a versão correta se necessário
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    neo4j-pkg
    jdk # Adiciona o Java Development Kit
  ];

  shellHook = ''
    echo "Ambiente de desenvolvimento com Draw.io, Neo4j e Java carregado!"

    # Define o diretório de trabalho para o Neo4j no HOME do usuário
    export NEO4J_WORK_DIR="$HOME/neo4j-streaming-work"
    export NEO4J_CONF_DIR="$NEO4J_WORK_DIR/conf"
    export NEO4J_DATA_DIR="$NEO4J_WORK_DIR/data"
    export NEO4J_LOGS_DIR="$NEO4J_WORK_DIR/logs"
    export NEO4J_RUN_DIR="$NEO4J_WORK_DIR/run" # Novo diretório para arquivos de execução

    # Limpa e recria os diretórios com permissões explícitas
    rm -rf "$NEO4J_WORK_DIR"
    mkdir -m 700 -p "$NEO4J_CONF_DIR" "$NEO4J_DATA_DIR" "$NEO4J_LOGS_DIR" "$NEO4J_RUN_DIR" # Inclui o diretório run

    # Copia os arquivos de configuração padrão para o diretório de trabalho
    cp "${neo4j-pkg}/share/neo4j/conf/neo4j.conf" "$NEO4J_CONF_DIR/neo4j.conf"
    cp "${neo4j-pkg}/share/neo4j/conf/user-logs.xml" "$NEO4J_CONF_DIR/user-logs.xml"
    cp "${neo4j-pkg}/share/neo4j/conf/server-logs.xml" "$NEO4J_CONF_DIR/server-logs.xml"

    # Modifica o neo4j.conf copiado para usar os diretórios de trabalho
    sed -i "s|#server.directories.data=data|server.directories.data=$NEO4J_DATA_DIR|" "$NEO4J_CONF_DIR/neo4j.conf"
    sed -i "s|#server.directories.logs=logs|server.directories.logs=$NEO4J_LOGS_DIR|" "$NEO4J_CONF_DIR/neo4j.conf"
    sed -i "s|#server.directories.run=run|server.directories.run=$NEO4J_RUN_DIR|" "$NEO4J_CONF_DIR/neo4j.conf" # Nova linha para o diretório run
    sed -i "s|#server.default_listen_address=0.0.0.0|server.default_listen_address=0.0.0.0|" "$NEO4J_CONF_DIR/neo4j.conf"

    # Modifica os arquivos de log4j para apontar para o diretório de logs gravável
    sed -i "s|/nix/store/[^/]*/share/neo4j/logs|$NEO4J_LOGS_DIR|g" "$NEO4J_CONF_DIR/user-logs.xml"
    sed -i "s|/nix/store/[^/]*/share/neo4j/logs|$NEO4J_LOGS_DIR|g" "$NEO4J_CONF_DIR/server-logs.xml"


    # Define as variáveis de ambiente para o Neo4j
    export NEO4J_HOME="${neo4j-pkg}/share/neo4j"
    export NEO4J_CONF="$NEO4J_CONF_DIR"
    export PATH="$NEO4J_HOME/bin:$PATH" # Adiciona o binário do neo4j ao PATH

    # Define JAVA_HOME para o Neo4j
    export JAVA_HOME="${pkgs.jdk}" # Define JAVA_HOME para o JDK do Nix

    echo "Configuração do Neo4j ajustada para usar diretórios graváveis em: $NEO4J_WORK_DIR"
    echo "Para iniciar o Draw.io, digite 'drawio'."
    echo "Para iniciar o Neo4j, digite 'neo4j start'."
    echo "Para parar o Neo4j, digite 'neo4j stop'."
    echo "Para executar o script Cypher, use 'cypher-shell -u neo4j -p neo4j -f streaming_service_movies_with_birth_info.cypher'"
  '';
}

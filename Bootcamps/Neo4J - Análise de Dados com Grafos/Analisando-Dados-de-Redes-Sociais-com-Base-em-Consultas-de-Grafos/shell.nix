{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  neo4j-pkg = pkgs.neo4j;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    neo4j-pkg
    jdk
  ];

  shellHook = ''
    # --- Configuração Definitiva (Caminhos Absolutos) ---
    export NEO4J_WORK_DIR="$HOME/neo4j-music-rec-work"
    export NEO4J_CONF_DIR="$NEO4J_WORK_DIR/conf"
    export NEO4J_DATA_DIR="$NEO4J_WORK_DIR/data"
    export NEO4J_LOGS_DIR="$NEO4J_WORK_DIR/logs"
    export NEO4J_RUN_DIR="$NEO4J_WORK_DIR/run"

    # 1. Cria a estrutura de diretórios completa
    rm -rf "$NEO4J_WORK_DIR"
    mkdir -p "$NEO4J_CONF_DIR" "$NEO4J_DATA_DIR" "$NEO4J_LOGS_DIR" "$NEO4J_RUN_DIR"

    # 2. Copia o neo4j.conf local
    cp "$PWD/neo4j.conf" "$NEO4J_CONF_DIR/neo4j.conf"

    # 3. Modifica o neo4j.conf para usar caminhos absolutos
    sed -i "s|server.directories.data=data|server.directories.data=$NEO4J_DATA_DIR|g" "$NEO4J_CONF_DIR/neo4j.conf"
    sed -i "s|server.directories.logs=logs|server.directories.logs=$NEO4J_LOGS_DIR|g" "$NEO4J_CONF_DIR/neo4j.conf"
    echo "" >> "$NEO4J_CONF_DIR/neo4j.conf"
    echo "# Caminho absoluto para o diretório 'run' (adicionado pelo shell.nix)" >> "$NEO4J_CONF_DIR/neo4j.conf"
    echo "server.directories.run=$NEO4J_RUN_DIR" >> "$NEO4J_CONF_DIR/neo4j.conf"

    # 4. Define as variáveis de ambiente
    export NEO4J_CONF="$NEO4J_CONF_DIR"
    export NEO4J_HOME="${neo4j-pkg}/share/neo4j"
    export JAVA_HOME="${pkgs.jdk}"
    export PATH="$NEO4J_HOME/bin:$PATH"

    echo "--- Ambiente Neo4j (Caminhos Absolutos) Configurado ---"
    echo "Diretório de trabalho: $NEO4J_WORK_DIR"
    echo "Use 'neo4j start' para iniciar."
  '';
}
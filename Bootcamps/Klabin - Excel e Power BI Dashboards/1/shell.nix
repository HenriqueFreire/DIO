{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) python3;
in
pkgs.mkShell {
  name = "file-server-env";

  buildInputs = [
    python3
  ];

  shellHook = ''
    echo "Bem-vindo ao ambiente de servidor de arquivos!"
    echo "Para iniciar um servidor HTTP simples na porta 8000, execute:"
    echo "python3 -m http.server 8000"
    echo "Você pode acessar os arquivos da sua máquina virtual em http://<IP_DA_SUA_MAQUINA_HOST>:8000"
    echo "Certifique-se de que a porta 8000 esteja aberta no firewall da sua máquina host, se houver."
  '';
}

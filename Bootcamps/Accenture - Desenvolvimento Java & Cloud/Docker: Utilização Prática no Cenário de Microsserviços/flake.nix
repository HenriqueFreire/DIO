{
  description = "E-commerce Microservices in C++20 with Drogon and Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = pkgsFor system;
          
          # Generic build function for microservices
          buildService = name: src: pkgs.stdenv.mkDerivation {
            inherit name;
            inherit src;
            nativeBuildInputs = with pkgs; [ cmake pkg-config cppcheck ];
            buildInputs = with pkgs; [
              drogon
              postgresql
              jsoncpp
              openssl
              zlib
              util-linux # for uuid
              gtest
            ];
            # C++20 support usually handled by modern gcc/clang in nixpkgs
            cmakeFlags = [ "-DCMAKE_CXX_STANDARD=20" ];

            doCheck = true;
            checkPhase = ''
              echo "Running static analysis with cppcheck..."
              cppcheck --enable=all --error-exitcode=1 .
              echo "Running unit tests..."
              ctest --output-on-failure
            '';
          };

        in
        rec {
          user-service = buildService "user-service" ./backend/services/user-service;
          product-service = buildService "product-service" ./backend/services/product-service;
          order-service = buildService "order-service" ./backend/services/order-service;

          # Docker Image factory
          makeImage = name: service: pkgs.dockerTools.streamLayeredImage {
            inherit name;
            tag = "latest";
            contents = [ service pkgs.cacert pkgs.postgresql.lib ];
            config = {
              Cmd = [ "${service}/bin/${name}" ];
              ExposedPorts = { "8080/tcp" = {}; };
              WorkingDir = "/";
            };
          };

          docker-user-service = makeImage "user-service" user-service;
          docker-product-service = makeImage "product-service" product-service;
          docker-order-service = makeImage "order-service" order-service;
          
          default = user-service;
        }
      );

      devShells = forAllSystems (system:
        let pkgs = pkgsFor system; in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              cmake
              drogon
              postgresql
              jsoncpp
              openssl
              git
            ];
          };
        }
      );
    };
}

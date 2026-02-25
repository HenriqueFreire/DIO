# Use uma imagem base mais recente para suportar C++20 (GCC 10+)
FROM debian:bullseye-slim

# Instalar dependências de compilação e runtime
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libjsoncpp-dev \
    libssl-dev \
    uuid-dev \
    zlib1g-dev \
    libpq-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Clonar e compilar Drogon
WORKDIR /usr/local/src
RUN git clone https://github.com/drogonframework/drogon
WORKDIR /usr/local/src/drogon
RUN git submodule update --init
RUN cmake -Bbuild -DCMAKE_CXX_STANDARD=20
RUN cmake --build build -j$(nproc)
RUN cmake --install build

# Criar diretório para a aplicação
WORKDIR /app

# Copiar os arquivos da aplicação
COPY . /app

# Build da aplicação Drogon com C++20
RUN cmake -Bbuild-app -DCMAKE_CXX_STANDARD=20
RUN cmake --build build-app -j$(nproc)

# Expor a porta (será configurada via cada serviço)
EXPOSE 8080

# Comando para executar a aplicação
CMD ["./build-app/service_binary"]

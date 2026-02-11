#include <iostream>
#include <vector>
#include <iomanip>
#include <random>
#include <sstream>
#include <string>

// Função para gerar uma chave privada aleatória de 256 bits (32 bytes)
std::string generatePrivateKey() {
  std::random_device rd; // Usado para semear o gerador de números aleatórios
  std::mt19937 gen(rd()); // Gerador de números aleatórios Mersenne Twister
  std::uniform_int_distribution<> distrib(0, 255); // Distribuição para bytes (0-255)

  std::vector<unsigned char> privateKeyBytes(32); // 256 bits = 32 bytes
  for (int i = 0; i < 32; ++i) {
    privateKeyBytes[i] = static_cast<unsigned char>(distrib(gen));
  }

  std::stringstream ss;
  for (int i = 0; i < 32; ++i) {
    // Formata cada byte como dois dígitos hexadecimais, preenchendo com zero se necessário
    ss << std::hex << std::setw(2) << std::setfill('0') << (int)privateKeyBytes[i];
  }

  return ss.str();
}

int main() {
  std::cout << "Gerando duas chaves privadas Bitcoin (Testnet) em formato hexadecimal..." << std::endl;

  std::string privateKey1 = generatePrivateKey();
  std::string privateKey2 = generatePrivateKey();

  std::cout << "\nChave Privada 1 (Hex): " << privateKey1 << std::endl;
  std::cout << "Chave Privada 2 (Hex): " << privateKey2 << std::endl;

  std::cout << "\n--- Próximos Passos ---" << std::endl;
  std::cout << "1. Compile e execute este código C++ para obter suas duas chaves privadas hexadecimais." << std::endl;
  std::cout << "2. Para converter estas chaves hexadecimais para o formato WIF (Wallet Import Format) e derivar os endereços Testnet correspondentes, você"
               " precisará de ferramentas que lidam com as operações criptográficas de curva elíptica e Base58Check." << std::endl;
  std::cout << "   Sugestões para o passo 2:" << std::endl;
  std::cout << "   - **Ferramenta Online:** Pesquise por 'private key to WIF converter testnet' ou 'hex private key to bitcoin address testnet' (use com"
               " cautela, pois você estará inserindo sua chave privada em um site)." << std::endl;
  std::cout << "   - **Script Python/JS:** Posso te ajudar a criar um pequeno script em Python ou JavaScript que use bibliotecas como `bitcoinlib` (Python) ou"
               " `bitcoinjs-lib` (JavaScript) para fazer essa derivação de forma segura localmente." << std::endl;
  std::cout << "3. Com as chaves WIF e os endereços Testnet em mãos, você poderá importá-las no Electrum Testnet." << std::endl;

  return 0;
}

#include <iostream>
#include <vector>
#include <string>
#include <iomanip>
#include <sstream>
#include <stdexcept>
#include <algorithm> // Para std::reverse

// Para SHA256 e RIPEMD160
#include <openssl/sha.h>
#include <openssl/ripemd.h>

// Para secp256k1
#include <secp256k1.h>

// --- Funções Utilitárias (Hex, Base58) ---

// Converte string hexadecimal para vetor de bytes
std::vector<unsigned char> hexToBytes(const std::string& hex) {
  if (hex.length() % 2 != 0) {
    throw std::runtime_error("A string hexadecimal deve ter um número par de caracteres.");
  }
  std::vector<unsigned char> bytes;
  for (size_t i = 0; i < hex.length(); i += 2) {
    std::string byteString = hex.substr(i, 2);
    bytes.push_back(static_cast<unsigned char>(std::stoul(byteString, nullptr, 16)));
  }
  return bytes;
}

// Converte vetor de bytes para string hexadecimal
std::string bytesToHex(const std::vector<unsigned char>& bytes) {
  std::stringstream ss;
  ss << std::hex << std::setfill('0');
  for (unsigned char b : bytes) {
    ss << std::setw(2) << static_cast<int>(b);
  }
  return ss.str();
}

// Alfabeto Base58
const std::string BASE58_ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";

// Codificação Base58Check
std::string base58CheckEncode(const std::vector<unsigned char>& data) {
  // 1. Adiciona checksum
  std::vector<unsigned char> data_with_checksum = data;
  std::vector<unsigned char> hash1(SHA256_DIGEST_LENGTH);
  std::vector<unsigned char> hash2(SHA256_DIGEST_LENGTH);

  SHA256(data.data(), data.size(), hash1.data());
  SHA256(hash1.data(), hash1.size(), hash2.data());

  for (int i = 0; i < 4; ++i) {
    data_with_checksum.push_back(hash2[i]);
  }

  // 2. Codifica em Base58
  std::string result = "";
  std::vector<unsigned char> num = data_with_checksum;
  unsigned long long carry;

  // Conta zeros iniciais
  int leading_zeros = 0;
  for (unsigned char b : data_with_checksum) {
    if (b == 0) {
      leading_zeros++;
    } else {
      break;
    }
  }

  // Converte base 256 para base 58
  while (!num.empty() && !(num.size() == 1 && num[0] == 0)) {
    carry = 0;
    for (size_t i = 0; i < num.size(); ++i) {
      unsigned long long digit = num[i] + carry * 256;
      num[i] = digit / 58;
      carry = digit % 58;
    }
    result += BASE58_ALPHABET[carry];

    // Remove zeros iniciais de num
    while (!num.empty() && num[0] == 0) {
      num.erase(num.begin());
    }
  }

  // Adiciona '1's iniciais para bytes zero iniciais nos dados originais
  for (int i = 0; i < leading_zeros; ++i) {
    result += '1';
  }
  std::reverse(result.begin(), result.end());
  return result;
}

// --- Funções de Hashing ---

std::vector<unsigned char> sha256(const std::vector<unsigned char>& data) {
  std::vector<unsigned char> hash(SHA256_DIGEST_LENGTH);
  SHA256(data.data(), data.size(), hash.data());
  return hash;
}

std::vector<unsigned char> ripemd160(const std::vector<unsigned char>& data) {
  std::vector<unsigned char> hash(RIPEMD160_DIGEST_LENGTH);
  RIPEMD160(data.data(), data.size(), hash.data());
  return hash;
}

// --- Lógica Principal de Derivação ---

int main(int argc, char* argv[]) {
  if (argc < 2) {
    std::cerr << "Uso: " << argv[0] << " <chave_privada_hex_1> [chave_privada_hex_2] ..." << std::endl;
    return 1;
  }

  // Inicializa o contexto secp256k1
  secp256k1_context* ctx = secp256k1_context_create(SECP256K1_CONTEXT_SIGN | SECP256K1_CONTEXT_VERIFY);
  if (!ctx) {
    std::cerr << "Falha ao inicializar o contexto secp256k1." << std::endl;
    return 1;
  }

  for (int i = 1; i < argc; ++i) {
    std::string hex_private_key_str = argv[i];
    std::cout << "\nProcessando Chave Privada Hex " << i << ": " << hex_private_key_str << std::endl;

    try {
      std::vector<unsigned char> private_key_bytes = hexToBytes(hex_private_key_str);

      if (private_key_bytes.size() != 32) {
        throw std::runtime_error("Chave privada hexadecimal deve ter 32 bytes (64 caracteres).");
      }

      // 1. Deriva Chave Pública (Comprimida)
      secp256k1_pubkey public_key;
      if (!secp256k1_ec_pubkey_create(ctx, &public_key, private_key_bytes.data())) {
        throw std::runtime_error("Falha ao criar chave pública. Verifique se a chave privada é válida.");
      }

      std::vector<unsigned char> compressed_public_key_bytes(33);
      size_t outputlen = 33;
      secp256k1_ec_pubkey_serialize(ctx, compressed_public_key_bytes.data(), &outputlen, &public_key, SECP256K1_EC_COMPRESSED);

      // 2. Hash da Chave Pública (RIPEMD160(SHA256(Chave Pública)))
      std::vector<unsigned char> sha256_pubkey = sha256(compressed_public_key_bytes);
      std::vector<unsigned char> ripemd160_pubkey = ripemd160(sha256_pubkey);

      // 3. Endereço Testnet (P2PKH)
      std::vector<unsigned char> address_data;
      address_data.push_back(0x6F); // Byte de versão P2PKH da Testnet
      address_data.insert(address_data.end(), ripemd160_pubkey.begin(), ripemd160_pubkey.end());
      std::string testnet_address = base58CheckEncode(address_data);

      // 4. Chave Privada WIF (Comprimida)
      std::vector<unsigned char> wif_data;
      wif_data.push_back(0xEF); // Byte de versão WIF da Testnet
      wif_data.insert(wif_data.end(), private_key_bytes.begin(), private_key_bytes.end());
      wif_data.push_back(0x01); // Sufixo para chave pública comprimida
      std::string wif_private_key = base58CheckEncode(wif_data);

      std::cout << "  WIF Privada (Testnet): " << wif_private_key << std::endl;
      std::cout << "  Endereço Bitcoin (Testnet): " << testnet_address << std::endl;

    } catch (const std::exception& e) {
      std::cerr << "  Erro: " << e.what() << std::endl;
    }
  }

  secp256k1_context_destroy(ctx);
  return 0;
}
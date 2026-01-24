#include "ApiAssistant.h"
#include <iostream>
#include <cstdlib> // Required for getenv
#include <curl/curl.h>
#include <nlohmann/json.hpp>

// Use the nlohmann::json namespace
using json = nlohmann::json;

// This is a static callback function required by libcurl.
// It appends the data received from the HTTP request to a std::string.
size_t ApiAssistant::WriteCallback(void* contents, size_t size, size_t nmemb, void* userp) {
    ((std::string*)userp)->append((char*)contents, size * nmemb);
    return size * nmemb;
}

// The constructor attempts to read the OPENAI_API_KEY from environment variables.
ApiAssistant::ApiAssistant() {
    const char* key = getenv("OPENAI_API_KEY");
    if (key == nullptr) {
        apiKey = "";
        std::cerr << "Aviso: Variável de ambiente OPENAI_API_KEY não definida." << std::endl;
        std::cerr << "A funcionalidade de dica não funcionará." << std::endl;
    } else {
        apiKey = key;
    }
}

std::string ApiAssistant::getHint(const Question& question) {
    if (apiKey.empty()) {
        return "Erro: A chave da API (OPENAI_API_KEY) não está configurada.";
    }

    CURL* curl = curl_easy_init();
    if (!curl) {
        return "Erro: Falha ao inicializar a libcurl.";
    }

    // Prepare the data for the request
    std::string readBuffer; // String to store the response
    std::string questionContent = "Pergunta: " + question.questionText + "\nOpções:\n";
    for(const auto& option : question.options) {
        questionContent += option + "\n";
    }

    // Create the JSON request body
    json requestBody;
    requestBody["model"] = "gpt-3.5-turbo";
    requestBody["messages"] = json::array({
        {{"role", "system"}, {"content", "Você é um assistente prestativo em um jogo de perguntas. Forneça uma dica sutil e curta para a pergunta a seguir, mas não revele a resposta diretamente."}},
        {{"role", "user"}, {"content", questionContent}}
    });
    requestBody["max_tokens"] = 60;
    requestBody["temperature"] = 0.7; // A bit of creativity

    std::string requestBodyStr = requestBody.dump();

    // Set up HTTP headers
    struct curl_slist* headers = NULL;
    headers = curl_slist_append(headers, "Content-Type: application/json");
    std::string authHeader = "Authorization: Bearer " + apiKey;
    headers = curl_slist_append(headers, authHeader.c_str());

    // Set curl options
    curl_easy_setopt(curl, CURLOPT_URL, "https://api.openai.com/v1/chat/completions");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, requestBodyStr.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);
    // Set a timeout for the request
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 30L);

    // Perform the request
    CURLcode res = curl_easy_perform(curl);
    std::string hint = "Desculpe, não foi possível obter uma dica no momento.";

    if (res == CURLE_OK) {
        try {
            json responseJson = json::parse(readBuffer);
            // Check if the expected data is present in the JSON response
            if (responseJson.contains("choices") && responseJson["choices"].is_array() && !responseJson["choices"].empty()) {
                if (responseJson["choices"][0].contains("message") && responseJson["choices"][0]["message"].contains("content")) {
                    hint = responseJson["choices"][0]["message"]["content"];
                }
            }
        } catch (const json::parse_error& e) {
            std::cerr << "Erro ao analisar JSON da resposta: " << e.what() << std::endl;
            std::cerr << "Resposta recebida: " << readBuffer << std::endl;
        }
    } else {
        std::cerr << "curl_easy_perform() falhou: " << curl_easy_strerror(res) << std::endl;
    }

    // Cleanup
    curl_easy_cleanup(curl);
    curl_slist_free_all(headers);

    return hint;
}

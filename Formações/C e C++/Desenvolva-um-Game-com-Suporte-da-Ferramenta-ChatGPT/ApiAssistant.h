#ifndef API_ASSISTANT_H
#define API_ASSISTANT_H

#include <string>
#include "Quiz.h" // Include Quiz.h to use the Question struct

class ApiAssistant {
public:
    // Constructor reads the API key from environment variables
    ApiAssistant();

    // Fetches a hint for a given question from the AI model
    std::string getHint(const Question& question);

private:
    std::string apiKey;

    // Static callback function for libcurl to handle the HTTP response
    static size_t WriteCallback(void* contents, size_t size, size_t nmemb, void* userp);
};

#endif // API_ASSISTANT_H

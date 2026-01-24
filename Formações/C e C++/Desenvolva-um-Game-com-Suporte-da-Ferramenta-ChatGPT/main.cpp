#include <iostream>
#include <string>
#include <vector>
#include <cctype>
#include "Quiz.h"
#include "ApiAssistant.h" // Include the new header

// Function to display a question in a formatted way
void displayQuestion(const Question& q) {
    std::cout << "\n----------------------------------------\n";
    std::cout << "Pergunta: " << q.questionText << std::endl;
    std::cout << "----------------------------------------\n";
    for (const auto& option : q.options) {
        std::cout << option << std::endl;
    }
    std::cout << "----------------------------------------\n";
}

int main() {
    std::cout << "========================================" << std::endl;
    std::cout << "  Bem-vindo ao Jogo de Quiz com IA!   " << std::endl;
    std::cout << "========================================" << std::endl;

    Quiz quiz;
    ApiAssistant assistant; // Create an instance of our assistant

    while (!quiz.isFinished()) {
        Question currentQuestion = quiz.getCurrentQuestion();
        displayQuestion(currentQuestion);

        std::cout << "Sua resposta (A, B, C...) ou digite 'dica': ";
        std::string userInput;
        std::cin >> userInput;

        if (userInput == "dica") {
            std::cout << "\nBuscando dica da IA, por favor aguarde...\n";
            std::string hint = assistant.getHint(currentQuestion);
            std::cout << "\n****************************************\n";
            std::cout << "DICA: " << hint << std::endl;
            std::cout << "****************************************\n";
            // After showing the hint, the loop will repeat, showing the same question again.
        } else if (userInput.length() == 1) {
            char userChoice = std::toupper(static_cast<unsigned char>(userInput[0]));
            if (userChoice >= 'A' && userChoice <= 'D') {
                int answerIndex = userChoice - 'A'; // Convert 'A'->0, 'B'->1, etc.
                if (quiz.checkAnswer(answerIndex)) {
                    std::cout << "\n>>> Resposta Correta! <<<\n";
                } else {
                    std::cout << "\n>>> Resposta Incorreta. <<<\n";
                }
                quiz.nextQuestion(); // Move to the next question
            } else {
                std::cout << "\nOpção inválida. Tente novamente.\n";
            }
        } else {
            std::cout << "\nEntrada inválida. Tente novamente.\n";
        }
    }

    std::cout << "\n========================================" << std::endl;
    std::cout << "  Fim de Jogo! Obrigado por jogar.  " << std::endl;
    std::cout << "========================================" << std::endl;

    return 0;
}

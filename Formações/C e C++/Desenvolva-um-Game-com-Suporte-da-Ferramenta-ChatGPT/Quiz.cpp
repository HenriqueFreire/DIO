#include "Quiz.h"

Quiz::Quiz() : currentQuestionIndex(0) {
    // Let's populate our quiz with some questions.
    // The third element is the 0-based index of the correct answer.
    questions.push_back({
        "Qual a capital da França?",
        {"A) Londres", "B) Berlim", "C) Paris", "D) Madri"},
        2
    });

    questions.push_back({
        "Qual o resultado de 5 + 7?",
        {"A) 10", "B) 11", "C) 12", "D) 13"},
        2
    });

    questions.push_back({
        "Qual biblioteca C++ é comumente usada para requisições HTTP?",
        {"A) iostream", "B) libcurl", "C) string", "D) vector"},
        1
    });

    questions.push_back({
        "Em que ano o homem pisou na lua pela primeira vez?",
        {"A) 1965", "B) 1969", "C) 1972", "D) 1980"},
        1
    });
}

bool Quiz::isFinished() const {
    return currentQuestionIndex >= questions.size();
}

Question Quiz::getCurrentQuestion() const {
    if (!isFinished()) {
        return questions[currentQuestionIndex];
    }
    // Return an empty question if the quiz is over to avoid errors
    return {"Fim do Jogo!", {}, -1};
}

bool Quiz::checkAnswer(int answerIndex) {
    if (!isFinished()) {
        return answerIndex == questions[currentQuestionIndex].correctAnswerIndex;
    }
    return false;
}

void Quiz::nextQuestion() {
    if (!isFinished()) {
        currentQuestionIndex++;
    }
}

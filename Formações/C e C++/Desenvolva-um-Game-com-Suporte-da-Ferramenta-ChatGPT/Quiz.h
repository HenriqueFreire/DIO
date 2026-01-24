#ifndef QUIZ_H
#define QUIZ_H

#include <string>
#include <vector>

// Represents a single multiple-choice question
struct Question {
    std::string questionText;
    std::vector<std::string> options;
    int correctAnswerIndex; // 0-based index for the options vector
};

// Manages the quiz logic and state
class Quiz {
public:
    // Constructor to initialize the quiz and load questions
    Quiz();

    // Checks if the quiz has any questions left
    bool isFinished() const;

    // Returns the current question
    Question getCurrentQuestion() const;

    // Checks if the given answer index is correct for the current question
    bool checkAnswer(int answerIndex);

    // Moves to the next question
    void nextQuestion();

private:
    std::vector<Question> questions;
    size_t currentQuestionIndex;
};

#endif // QUIZ_H

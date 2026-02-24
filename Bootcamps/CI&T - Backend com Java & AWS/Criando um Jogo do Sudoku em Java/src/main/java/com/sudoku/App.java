package com.sudoku;

import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        SudokuBoard board = new SudokuBoard();

        System.out.println("Bem-vindo ao Sudoku!");

        while (true) {
            board.generateNewBoard();
            board.removeNumbers(40); // Remove 40 numbers for a puzzle
            System.out.println("Novo jogo gerado:");
            board.printBoard();

            while (true) {
                System.out.println("\nDigite sua jogada (linha coluna valor), ou 'novo' para um novo jogo, ou 'sair' para sair:");
                String input = scanner.nextLine();

                if (input.equalsIgnoreCase("sair")) {
                    System.out.println("Obrigado por jogar!");
                    scanner.close();
                    return;
                } else if (input.equalsIgnoreCase("novo")) {
                    break; // Break inner loop to generate a new game
                }

                try {
                    String[] parts = input.split(" ");
                    if (parts.length != 3) {
                        System.out.println("Entrada inválida. Use 'linha coluna valor'.");
                        continue;
                    }

                    int row = Integer.parseInt(parts[0]) - 1; // Adjust to 0-indexed
                    int col = Integer.parseInt(parts[1]) - 1; // Adjust to 0-indexed
                    int value = Integer.parseInt(parts[2]);

                    if (row < 0 || row >= 9 || col < 0 || col >= 9) {
                        System.out.println("Linha e coluna devem ser entre 1 e 9.");
                        continue;
                    }

                    if (value < 0 || value > 9) {
                        System.out.println("Valor deve ser entre 0 (para limpar) e 9.");
                        continue;
                    }

                    // Check if it's an initial puzzle cell
                    if (board.getInitialValue(row, col) != 0) {
                        System.out.println("Você não pode mudar uma célula inicial do puzzle.");
                        continue;
                    }

                    if (board.isValid(row, col, value)) {
                        board.setValue(row, col, value);
                    } else {
                        System.out.println("Movimento inválido! Este número não pode ser colocado aqui.");
                    }

                    System.out.println("\nTabuleiro atual:");
                    board.printBoard();

                    // Check for win condition
                    boolean isSolved = true;
                    for (int r = 0; r < 9; r++) {
                        for (int c = 0; c < 9; c++) {
                            if (board.getValue(r, c) == 0) {
                                isSolved = false;
                                break;
                            }
                        }
                        if (!isSolved) break;
                    }

                    if (isSolved) {
                        SudokuBoard solvedBoard = new SudokuBoard(board); // Make a copy
                        if (solvedBoard.solve()) { // Check if the current board state is actually a solution
                            System.out.println("\nParabéns! Você resolveu o Sudoku!");
                            break; // Break inner loop to generate a new game
                        }
                    }

                } catch (NumberFormatException e) {
                    System.out.println("Entrada inválida. Linha, coluna e valor devem ser números.");
                } catch (IllegalArgumentException e) {
                    System.out.println("Erro: " + e.getMessage());
                }
            }
        }
    }
}

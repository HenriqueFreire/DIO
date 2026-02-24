package com.sudoku;

import java.util.Random; // Moved to the top

public class SudokuBoard {
    private int[][] board;
    private int[][] initialBoard; // To store the original puzzle
    private static final int SIZE = 9;

    public SudokuBoard() {
        this.board = new int[SIZE][SIZE];
        this.initialBoard = new int[SIZE][SIZE];
        // Initialize with zeros (empty cells)
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                this.board[i][j] = 0;
                this.initialBoard[i][j] = 0;
            }
        }
    }

    // Copy constructor for deep copy
    public SudokuBoard(SudokuBoard other) {
        this.board = new int[SIZE][SIZE];
        this.initialBoard = new int[SIZE][SIZE];
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                this.board[i][j] = other.board[i][j];
                this.initialBoard[i][j] = other.initialBoard[i][j];
            }
        }
    }

    public int getValue(int row, int col) {
        if (row < 0 || row >= SIZE || col < 0 || col >= SIZE) {
            throw new IllegalArgumentException("Invalid row or column index.");
        }
        return board[row][col];
    }

    public int getInitialValue(int row, int col) {
        if (row < 0 || row >= SIZE || col < 0 || col >= SIZE) {
            throw new IllegalArgumentException("Invalid row or column index.");
        }
        return initialBoard[row][col];
    }

    public void setValue(int row, int col, int value) {
        if (row < 0 || row >= SIZE || col < 0 || col >= SIZE) {
            throw new IllegalArgumentException("Invalid row or column index.");
        }
        if (value < 0 || value > 9) {
            throw new IllegalArgumentException("Value must be between 0 and 9 (0 for empty).");
        }
        this.board[row][col] = value;
    }

    // A basic method to print the board (for CLI display later)
    public void printBoard() {
        for (int i = 0; i < SIZE; i++) {
            if (i % 3 == 0 && i != 0) {
                System.out.println("---------------------");
            }
            for (int j = 0; j < SIZE; j++) {
                if (j % 3 == 0 && j != 0) {
                    System.out.print("| ");
                }
                System.out.print(board[i][j] == 0 ? ". " : board[i][j] + " ");
            }
            System.out.println();
        }
    }

    public boolean isValid(int row, int col, int value) {
        if (value == 0) { // 0 representa uma célula vazia, que é sempre válida para "colocar" (ou seja, limpar)
            return true;
        }

        // Verifica a linha
        for (int c = 0; c < SIZE; c++) {
            if (c == col) continue; // Pula a célula que estamos verificando
            if (board[row][c] == value) {
                return false;
            }
        }

        // Verifica a coluna
        for (int r = 0; r < SIZE; r++) {
            if (r == row) continue; // Pula a célula que estamos verificando
            if (board[r][col] == value) {
                return false;
            }
        }

        // Verifica a caixa 3x3
        int startRow = row - row % 3;
        int startCol = col - col % 3;
        for (int r = startRow; r < startRow + 3; r++) {
            for (int c = startCol; c < startCol + 3; c++) {
                if (r == row && c == col) continue; // Pula a célula que estamos verificando
                if (board[r][c] == value) {
                    return false;
                }
            }
        }

        return true;
    }

    public void generateNewBoard() {
        // Clear the board
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                this.board[i][j] = 0;
            }
        }
        fillBoard(0, 0);

        // Copy the generated full board to initialBoard
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                this.initialBoard[i][j] = this.board[i][j];
            }
        }
    }

    private boolean fillBoard(int row, int col) {
        if (row == SIZE) {
            return true; // Board filled
        }

        int nextRow = col == SIZE - 1 ? row + 1 : row;
        int nextCol = col == SIZE - 1 ? 0 : col + 1;

        Random random = new Random();
        int[] numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9};
        // Shuffle numbers for random board generation
        for (int i = 0; i < numbers.length; i++) {
            int randomIndex = random.nextInt(numbers.length);
            int temp = numbers[i];
            numbers[i] = numbers[randomIndex];
            numbers[randomIndex] = temp;
        }

        for (int number : numbers) {
            if (isValid(row, col, number)) {
                board[row][col] = number;
                if (fillBoard(nextRow, nextCol)) {
                    return true;
                }
                board[row][col] = 0; // Backtrack
            }
        }
        return false;
    }

    public void removeNumbers(int count) {
        Random random = new Random();
        int removedCount = 0;
        // Make a copy of the board to check for unique solutions without altering the current state
        int[][] tempBoard = new int[SIZE][SIZE];
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                tempBoard[i][j] = this.board[i][j];
            }
        }

        while (removedCount < count) {
            int row = random.nextInt(SIZE);
            int col = random.nextInt(SIZE);

            if (tempBoard[row][col] != 0) { // Check tempBoard
                int tempValue = tempBoard[row][col];
                tempBoard[row][col] = 0; // Temporarily remove from tempBoard

                // Create a temporary SudokuBoard to check for unique solutions
                SudokuBoard testBoard = new SudokuBoard();
                testBoard.board = new int[SIZE][SIZE]; // Deep copy for test board
                for (int i = 0; i < SIZE; i++) {
                    for (int j = 0; j < SIZE; j++) {
                        testBoard.board[i][j] = tempBoard[i][j];
                    }
                }

                if (testBoard.countSolutions() == 1) {
                    this.board[row][col] = 0; // If unique solution, apply to actual board
                    removedCount++;
                } else {
                    tempBoard[row][col] = tempValue; // If not unique, revert tempBoard
                }
            }
        }
        // After removing numbers, copy the final puzzle to initialBoard
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                this.initialBoard[i][j] = this.board[i][j];
            }
        }
    }

    public boolean solve() {
        return solve(0, 0);
    }

    private boolean solve(int row, int col) {
        if (row == SIZE) {
            return true; // Board solved
        }

        int nextRow = col == SIZE - 1 ? row + 1 : row;
        int nextCol = col == SIZE - 1 ? 0 : col + 1;

        if (board[row][col] != 0) { // If cell is already filled, move to the next
            return solve(nextRow, nextCol);
        }

        for (int number = 1; number <= 9; number++) {
            if (isValid(row, col, number)) {
                board[row][col] = number;
                if (solve(nextRow, nextCol)) {
                    return true;
                }
            }
        }
        board[row][col] = 0; // Backtrack
        return false;
    }

    public int countSolutions() {
        // Create a deep copy of the current board state to allow the recursive solver to modify it
        // without affecting the original board, which might be needed for further operations
        SudokuBoard tempBoard = new SudokuBoard(this);
        // Start the recursive counting process. We usually only need to know if there's 0, 1, or >1 solutions.
        // So, a limit of 2 is efficient enough to determine uniqueness.
        return tempBoard.countSolutionsRecursive(0, 0, 0, 2);
    }

    /**
     * Recursive helper method to count the number of solutions for the Sudoku board.
     * It stops counting once the limit is reached to improve performance.
     *
     * @param row The current row being processed.
     * @param col The current column being processed.
     * @param currentSolutions The number of solutions found so far in this recursive path.
     * @param limit The maximum number of solutions to find before stopping.
     * @return The total number of solutions found up to the limit.
     */
    private int countSolutionsRecursive(int row, int col, int currentSolutions, int limit) {
        // If we have already found solutions up to our limit, we can stop early.
        if (currentSolutions >= limit) {
            return currentSolutions;
        }

        // If we've advanced past the last row, a solution has been found.
        if (row == SIZE) {
            return currentSolutions + 1;
        }

        // Calculate the next cell to process.
        int nextRow = col == SIZE - 1 ? row + 1 : row;
        int nextCol = col == SIZE - 1 ? 0 : col + 1;

        // If the current cell is already filled, move to the next cell.
        if (board[row][col] != 0) {
            return countSolutionsRecursive(nextRow, nextCol, currentSolutions, limit);
        }

        // Try placing numbers from 1 to 9 in the current empty cell.
        for (int number = 1; number <= 9; number++) {
            if (isValid(row, col, number)) {
                board[row][col] = number; // Place the number
                // Recursively call for the next cell, accumulating solutions.
                currentSolutions = countSolutionsRecursive(nextRow, nextCol, currentSolutions, limit);
                board[row][col] = 0; // Backtrack: remove the number for the next iteration
                // If we've hit our limit during the recursive call, propagate that limit up.
                if (currentSolutions >= limit) {
                    return currentSolutions;
                }
            }
        }
        return currentSolutions; // Return the total solutions found from this path
    }

    

        public boolean isBoardSolved() {

            for (int r = 0; r < SIZE; r++) {

                for (int c = 0; c < SIZE; c++) {

                    if (board[r][c] == 0) {

                        return false; // Not all cells are filled

                    }

                }

            }

            return true; // All cells are filled

        }

    

        public boolean checkIfSolved() {

            if (!isBoardSolved()) {

                return false; // Board is not even full

            }

    

            // Check each cell for validity

            for (int r = 0; r < SIZE; r++) {

                for (int c = 0; c < SIZE; c++) {

                    int value = board[r][c];

                    board[r][c] = 0; // Temporarily remove to check conflicts with OTHER cells

                    if (!isValid(r, c, value)) {

                        board[r][c] = value; // Put it back

                        return false;

                    }

                    board[r][c] = value; // Put it back

                }

            }

            return true; // All cells are filled and valid

        }

    }

    
package com.sudoku;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class SudokuBoardTest {

    private SudokuBoard board;

    @BeforeEach
    void setUp() {
        board = new SudokuBoard();
    }

    @Test
    void testConstructorAndGetSetValue() {
        assertEquals(0, board.getValue(0, 0));
        board.setValue(0, 0, 5);
        assertEquals(5, board.getValue(0, 0));
    }

    @Test
    void testInvalidSetValues() {
        assertThrows(IllegalArgumentException.class, () -> board.setValue(-1, 0, 1));
        assertThrows(IllegalArgumentException.class, () -> board.setValue(0, 0, 10));
    }

    @Test
    void testIsValid() {
        // Test 1: Valid placement
        assertTrue(board.isValid(0, 0, 1), "Placing 1 at (0,0) on empty board should be valid.");

        board.setValue(0, 0, 5); // Place a 5 at (0,0)

        // Test 2: Row conflict
        assertFalse(board.isValid(0, 1, 5), "Placing 5 at (0,1) should be invalid due to row conflict.");

        // Test 3: Column conflict
        assertFalse(board.isValid(1, 0, 5), "Placing 5 at (1,0) should be invalid due to column conflict.");

        // Test 4: 3x3 box conflict
        assertFalse(board.isValid(1, 1, 5), "Placing 5 at (1,1) should be invalid due to 3x3 box conflict.");

        // Test 5: Valid placement with existing numbers
        assertTrue(board.isValid(0, 1, 4), "Placing 4 at (0,1) should be valid when 5 is at (0,0).");
        assertFalse(board.isValid(1, 2, 5), "Placing 5 at (1,2) should be invalid due to 3x3 box conflict with (0,0).");

        board.setValue(0, 1, 1);
        board.setValue(1, 0, 2);
        board.setValue(1, 1, 3);

        // Test 6: Check multiple conflicts at once
        assertFalse(board.isValid(0, 2, 1), "Placing 1 at (0,2) should conflict with (0,1).");
        assertFalse(board.isValid(2, 0, 2), "Placing 2 at (2,0) should conflict with (1,0).");
        assertFalse(board.isValid(2, 2, 3), "Placing 3 at (2,2) should conflict with (1,1).");

        // Test 7: Placing 0 should always be valid
        assertTrue(board.isValid(0, 0, 0), "Placing 0 (clearing) should always be valid.");
    }

    @Test
    void testGenerateNewBoard() {
        board.generateNewBoard();
        // Check if all cells are filled
        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                assertTrue(board.getValue(r, c) >= 1 && board.getValue(r, c) <= 9);
            }
        }
        // Check if the generated board is valid
        // Need to temporarily set board[r][c] = 0 to use isValid
        SudokuBoard tempBoard = new SudokuBoard(board); // Make a copy
        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                int value = tempBoard.getValue(r, c);
                tempBoard.setValue(r, c, 0); // Temporarily remove value to check
                assertTrue(tempBoard.isValid(r, c, value));
                tempBoard.setValue(r, c, value); // Put it back
            }
        }
    }

    @Test
    void testSolveKnownPuzzle() {
        // A simple solvable puzzle
        int[][] puzzle = {
            {5, 3, 0, 0, 7, 0, 0, 0, 0},
            {6, 0, 0, 1, 9, 5, 0, 0, 0},
            {0, 9, 8, 0, 0, 0, 0, 6, 0},
            {8, 0, 0, 0, 6, 0, 0, 0, 3},
            {4, 0, 0, 8, 0, 3, 0, 0, 1},
            {7, 0, 0, 0, 2, 0, 0, 0, 6},
            {0, 6, 0, 0, 0, 0, 2, 8, 0},
            {0, 0, 0, 4, 1, 9, 0, 0, 5},
            {0, 0, 0, 0, 8, 0, 0, 7, 9}
        };
        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                board.setValue(r, c, puzzle[r][c]);
            }
        }

        SudokuBoard boardForSolutions = new SudokuBoard(board); // Make a copy to not alter the main board
        int numSolutions = boardForSolutions.countSolutions();
        // System.out.println("Number of solutions found for the puzzle: " + numSolutions); // Keep this commented for now
        
        assertTrue(board.solve());
        assertTrue(board.checkIfSolved(), "The solved board should be a valid Sudoku solution.");

        int[][] expectedSolution = {
            {5, 3, 4, 6, 7, 8, 9, 1, 2},
            {6, 7, 2, 1, 9, 5, 3, 4, 8},
            {1, 9, 8, 3, 4, 2, 5, 6, 7},
            {8, 5, 9, 7, 6, 1, 4, 2, 3},
            {4, 2, 6, 8, 5, 3, 7, 9, 1},
            {7, 1, 3, 9, 2, 4, 8, 5, 6},
            {9, 6, 1, 5, 3, 7, 2, 8, 4},
            {2, 8, 7, 4, 1, 9, 6, 3, 5},
            {3, 4, 5, 2, 8, 6, 1, 7, 9}
        };

        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                assertEquals(expectedSolution[r][c], board.getValue(r, c),
                    "Cell (" + r + "," + c + ") value incorrect after solving.");
            }
        }
    }

    @Test
    void testCountSolutions() {
        // A puzzle with one known solution
        int[][] uniquePuzzle = {
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0}
        };
        // Filling a minimal unique puzzle is complex.
        // For simplicity, let's test a full board first, which should have 1 solution.
        board.generateNewBoard();
        assertEquals(1, board.countSolutions());

        // Test with an empty board (should have many solutions, but countSolutions will stop at 2 for optimization)
        board = new SudokuBoard();
        assertTrue(board.countSolutions() > 1); // Should find more than 1 solution

    }

    // @Test
    // void testRemoveNumbersAndUniqueSolution() {
    //     board.generateNewBoard();
    //     int[][] fullBoard = new int[9][9];
    //     for (int r = 0; r < 9; r++) {
    //         for (int c = 0; c < 9; c++) {
    //             fullBoard[r][c] = board.getValue(r, c);
    //         }
    //     }

    //     board.removeNumbers(30); // Remove 30 numbers

    //     // Ensure numbers are actually removed
    //     int removedCount = 0;
    //     for (int r = 0; r < 9; r++) {
    //         for (int c = 0; c < 9; c++) {
    //             if (board.getValue(r, c) == 0) {
    //                 removedCount++;
    //             }
    //         }
    //     }
    //     assertTrue(removedCount >= 30); // It might remove slightly more due to random choices on already empty cells sometimes
        
    //     // Ensure the puzzle is still solvable and has a unique solution
    //     SudokuBoard testBoard = new SudokuBoard(board);
    //     assertEquals(1, testBoard.countSolutions());
    // }
}

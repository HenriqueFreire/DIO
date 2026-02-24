package br.com.dio.service;

import br.com.dio.persistence.entity.BoardColumnEntity;
import br.com.dio.persistence.entity.BoardColumnKindEnum;
import br.com.dio.persistence.entity.BoardEntity;
import org.jdbi.v3.core.Jdbi;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BoardServiceTest {

    private Jdbi jdbi;
    private Connection connection;
    private BoardService boardService;

    private static final Logger log = LoggerFactory.getLogger(BoardServiceTest.class);

    @BeforeEach
    void setUp() throws SQLException { // Removed LiquibaseException
        // Setup H2 in-memory database
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1");

        // Manually create tables for H2
        try (var stmt = connection.createStatement()) {
            stmt.execute("""
                CREATE TABLE BOARDS(
                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(255) NOT NULL
                );
                """);
            stmt.execute("""
                CREATE TABLE BOARDS_COLUMNS(
                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(255) NOT NULL,
                    `order` int NOT NULL,
                    kind VARCHAR(7) NOT NULL,
                    board_id BIGINT NOT NULL,
                    CONSTRAINT boards__boards_columns_fk FOREIGN KEY (board_id) REFERENCES BOARDS(id) ON DELETE CASCADE
                );
                """);
            // Note: `id_order_uk UNIQUE KEY unique_board_id_order (board_id, `order`)` constraint is omitted for simplicity
            // as it's not directly tested by BoardService operations here.
        }

        // Setup JDBI with the H2 connection
        jdbi = Jdbi.create(connection);
        jdbi.installPlugin(new org.jdbi.v3.sqlobject.SqlObjectPlugin());
        boardService = new BoardService(jdbi);
    }

    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            // Drop all objects from the schema to ensure a clean state for the next test
            jdbi.withHandle(handle -> handle.execute("DROP ALL OBJECTS"));
            connection.close();
        }
    }

    @Test
    void insertBoardShouldReturnBoardWithGeneratedId() {
        BoardEntity board = new BoardEntity();
        board.setName("Test Board");

        BoardColumnEntity column = new BoardColumnEntity();
        column.setName("Initial Column");
        column.setKind(BoardColumnKindEnum.INITIAL);
        column.setOrder(0);
        board.setBoardColumns(List.of(column));

        boardService.insert(board);

        assertNotNull(board.getId());
        assertTrue(board.getId() > 0);
        assertEquals("Test Board", board.getName());
    }

    @Test
    void deleteBoardShouldReturnTrueIfBoardExists() {
        BoardEntity board = new BoardEntity();
        board.setName("Board to Delete");
        BoardColumnEntity column = new BoardColumnEntity();
        column.setName("Initial Column");
        column.setKind(BoardColumnKindEnum.INITIAL);
        column.setOrder(0);
        board.setBoardColumns(List.of(column));

        boardService.insert(board);
        assertNotNull(board.getId());

        boolean deleted = boardService.delete(board.getId());
        assertTrue(deleted);
    }

    @Test
    void deleteBoardShouldReturnFalseIfBoardDoesNotExist() {
        boolean deleted = boardService.delete(999L); // Non-existent ID
        assertFalse(deleted);
    }
}
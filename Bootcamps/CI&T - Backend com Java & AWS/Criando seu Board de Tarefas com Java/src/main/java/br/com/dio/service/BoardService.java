package br.com.dio.service;

import br.com.dio.persistence.dao.BoardColumnDAO;
import br.com.dio.persistence.dao.BoardDAO;
import br.com.dio.persistence.entity.BoardEntity;
import lombok.AllArgsConstructor;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException; // This import might become unused later

@AllArgsConstructor
public class BoardService {

    private final Jdbi jdbi;

    public BoardEntity insert(final BoardEntity entity) {
        return jdbi.inTransaction(handle -> {
            var boardDao = handle.attach(BoardDAO.class);
            var generatedId = boardDao.insert(entity);
            entity.setId(generatedId);

            var boardColumnDAO = handle.attach(BoardColumnDAO.class); // Use JDBI attached DAO
            var columns = entity.getBoardColumns().stream().map(c -> {
                c.setBoard(entity); // Ensure the BoardEntity is set in the column
                return c;
            }).toList();
            for (var column :  columns){
                boardColumnDAO.insert(column); // No SQLException to catch directly
            }
            return entity;
        });
    }

    public boolean delete(final Long id) {
        return jdbi.inTransaction(handle -> {
            var boardDao = handle.attach(BoardDAO.class);
            if (!boardDao.exists(id)) {
                return false;
            }
            boardDao.delete(id);
            return true;
        });
    }

}

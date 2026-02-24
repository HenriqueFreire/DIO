package br.com.dio.service;

import br.com.dio.dto.BoardDetailsDTO;
import br.com.dio.persistence.dao.BoardColumnDAO;
import br.com.dio.persistence.dao.BoardDAO;
import br.com.dio.persistence.entity.BoardEntity;
import lombok.AllArgsConstructor;
import org.jdbi.v3.core.Jdbi;

import java.util.Optional;

@AllArgsConstructor
public class BoardQueryService {

    private final Jdbi jdbi;

    public Optional<BoardEntity> findById(final Long id) { // Removed SQLException
        return jdbi.withHandle(handle -> {
            var boardDao = handle.attach(BoardDAO.class);
            var optional = boardDao.findById(id);
            if (optional.isPresent()){
                var entity = optional.get();
                var boardColumnDao = handle.attach(BoardColumnDAO.class);
                entity.setBoardColumns(boardColumnDao.findByBoardId(entity.getId()));
                return Optional.of(entity);
            }
            return Optional.empty();
        });
    }

    public Optional<BoardDetailsDTO> showBoardDetails(final Long id) { // Removed SQLException
        return jdbi.withHandle(handle -> {
            var boardDao = handle.attach(BoardDAO.class);
            var boardColumnDao = handle.attach(BoardColumnDAO.class); // Get from handle
            var optional = boardDao.findById(id);
            if (optional.isPresent()){
                var entity = optional.get();
                var columns = boardColumnDao.findByBoardIdWithDetails(entity.getId());
                var dto = new BoardDetailsDTO(entity.getId(), entity.getName(), columns);
                return Optional.of(dto);
            }
            return Optional.empty();
        });
    }

}

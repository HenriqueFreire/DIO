package br.com.dio.persistence.dao;

import br.com.dio.dto.BoardColumnDTO;
import br.com.dio.persistence.entity.BoardColumnEntity;
// import br.com.dio.persistence.entity.CardEntity; // REMOVED
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;
import java.util.Optional;

// Register mapper for BoardColumnEntity
@RegisterBeanMapper(BoardColumnEntity.class)
// Register mapper for BoardColumnDTO
@RegisterBeanMapper(BoardColumnDTO.class)
// Register mapper for CardEntity (for findById with cards) // REMOVED
// @RegisterBeanMapper(value = CardEntity.class, prefix = "c") // REMOVED
public interface BoardColumnDAO {

    @SqlUpdate("INSERT INTO BOARDS_COLUMNS (name, `order`, kind, board_id) VALUES (:name, :order, :kind, :board.id)")
    @GetGeneratedKeys
    Long insert(@BindBean BoardColumnEntity boardColumn);

    @SqlQuery("SELECT id, name, `order`, kind FROM BOARDS_COLUMNS WHERE board_id = :boardId ORDER BY `order`")
    List<BoardColumnEntity> findByBoardId(@Bind("boardId") Long boardId);

    @SqlQuery("""
                SELECT bc.id,
                       bc.name,
                       bc.kind,
                       (SELECT COUNT(c.id)
                               FROM CARDS c
                              WHERE c.board_column_id = bc.id) AS cards_amount
                  FROM BOARDS_COLUMNS bc
                 WHERE board_id = :boardId
                 ORDER BY `order`
            """)
    List<BoardColumnDTO> findByBoardIdWithDetails(@Bind("boardId") Long boardId);
}
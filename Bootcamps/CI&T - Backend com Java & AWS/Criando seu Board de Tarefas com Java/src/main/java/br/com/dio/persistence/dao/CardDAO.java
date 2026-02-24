package br.com.dio.persistence.dao;

import br.com.dio.dto.CardDetailsDTO;
import br.com.dio.persistence.entity.CardEntity;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.config.RegisterConstructorMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.Optional;

@RegisterBeanMapper(CardEntity.class)
@RegisterConstructorMapper(CardDetailsDTO.class) // Assuming constructor parameter names match column aliases
public interface CardDAO {

    @SqlUpdate("INSERT INTO CARDS (title, description, board_column_id) VALUES (:title, :description, :boardColumn.id)")
    @GetGeneratedKeys
    Long insert(@BindBean CardEntity card);

    @SqlUpdate("UPDATE CARDS SET board_column_id = :columnId WHERE id = :cardId")
    void moveToColumn(@Bind("columnId") Long columnId, @Bind("cardId") Long cardId);

    @SqlQuery("""
                SELECT c.id,
                       c.title,
                       c.description,
                       b.blocked_at,
                       b.block_reason,
                       c.board_column_id AS boardColumnId,
                       bc.name AS boardColumnName,
                       (SELECT COUNT(sub_b.id)
                               FROM BLOCKS sub_b
                              WHERE sub_b.card_id = c.id) AS blocks_amount,
                       CASE WHEN b.block_reason IS NOT NULL THEN TRUE ELSE FALSE END AS blocked
                  FROM CARDS c
                  LEFT JOIN BLOCKS b
                    ON c.id = b.card_id
                   AND b.unblocked_at IS NULL
                 INNER JOIN BOARDS_COLUMNS bc
                    ON bc.id = c.board_column_id
                 WHERE c.id = :id
            """)
    Optional<CardDetailsDTO> findById(@Bind("id") Long id);

}
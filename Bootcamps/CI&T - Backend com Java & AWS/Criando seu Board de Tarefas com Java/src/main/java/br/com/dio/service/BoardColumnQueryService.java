package br.com.dio.service;

import br.com.dio.persistence.dao.BoardColumnDAO;
import br.com.dio.persistence.entity.BoardColumnEntity;
import br.com.dio.persistence.entity.CardEntity;
import br.com.dio.persistence.entity.BoardColumnKindEnum; // IMPORT ADDED
import lombok.AllArgsConstructor;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.result.ResultIterable; // This import might become unused

import java.util.Optional;
import java.util.HashMap;
import java.util.List; // IMPORT ADDED
import java.util.Map;

import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;

@AllArgsConstructor
public class BoardColumnQueryService {

    private final Jdbi jdbi;

    public Optional<BoardColumnEntity> findById(final Long id) { // Removed SQLException
        return jdbi.withHandle(handle -> {
            var boardColumnDao = handle.attach(BoardColumnDAO.class);
            // This query returns columns for BoardColumnEntity and prefixed columns for CardEntity
            List<Map<String, Object>> results = handle.createQuery("""
        SELECT bc.id,
               bc.name,
               bc.kind,
               bc.order,
               c.id AS c_id,
               c.title AS c_title,
               c.description AS c_description
          FROM BOARDS_COLUMNS bc
          LEFT JOIN CARDS c
            ON c.board_column_id = bc.id
         WHERE bc.id = :boardColumnId
        """)
                .bind("boardColumnId", id)
                .mapToMap()
                .list();

            if (results.isEmpty()) { // Now works with List.isEmpty()
                return Optional.empty();
            }

            BoardColumnEntity boardColumnEntity = null;
            Map<Long, CardEntity> cardsMap = new HashMap<>();

            for (Map<String, Object> row : results) {
                if (boardColumnEntity == null) {
                    boardColumnEntity = new BoardColumnEntity();
                    boardColumnEntity.setId((Long) row.get("id"));
                    boardColumnEntity.setName((String) row.get("name"));
                    boardColumnEntity.setKind(BoardColumnKindEnum.valueOf((String) row.get("kind")));
                    boardColumnEntity.setOrder((Integer) row.get("order"));
                }

                Long cardId = (Long) row.get("c_id");
                if (nonNull(cardId) && !cardsMap.containsKey(cardId)) {
                    CardEntity card = new CardEntity();
                    card.setId(cardId);
                    card.setTitle((String) row.get("c_title"));
                    card.setDescription((String) row.get("c_description"));
                    boardColumnEntity.getCards().add(card);
                    cardsMap.put(cardId, card);
                }
            }
            return Optional.ofNullable(boardColumnEntity);
        });
    }

}

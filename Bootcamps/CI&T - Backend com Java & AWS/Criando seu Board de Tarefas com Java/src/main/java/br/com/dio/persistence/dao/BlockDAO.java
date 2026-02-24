package br.com.dio.persistence.dao;

import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.time.OffsetDateTime;

public interface BlockDAO {

    @SqlUpdate("INSERT INTO BLOCKS (blocked_at, block_reason, card_id) VALUES (:blockedAt, :reason, :cardId)")
    void block(@Bind("reason") String reason, @Bind("cardId") Long cardId, @Bind("blockedAt") OffsetDateTime blockedAt);

    @SqlUpdate("UPDATE BLOCKS SET unblocked_at = :unblockedAt, unblock_reason = :reason WHERE card_id = :cardId AND unblocked_at IS NULL")
    void unblock(@Bind("reason") String reason, @Bind("cardId") Long cardId, @Bind("unblockedAt") OffsetDateTime unblockedAt);

}
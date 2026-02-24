package br.com.dio.persistence.dao;

import br.com.dio.persistence.entity.BoardEntity;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.Optional;

@RegisterBeanMapper(BoardEntity.class)
public interface BoardDAO {

    @SqlUpdate("INSERT INTO BOARDS (name) VALUES (:name)")
    @GetGeneratedKeys
    Long insert(@BindBean BoardEntity board);

    @SqlUpdate("DELETE FROM BOARDS WHERE id = :id")
    void delete(@Bind("id") Long id);

    @SqlQuery("SELECT id, name FROM BOARDS WHERE id = :id")
    Optional<BoardEntity> findById(@Bind("id") Long id);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM BOARDS WHERE id = :id)")
    boolean exists(@Bind("id") Long id);
}
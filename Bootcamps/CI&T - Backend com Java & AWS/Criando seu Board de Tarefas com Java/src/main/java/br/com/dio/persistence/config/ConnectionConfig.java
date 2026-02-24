package br.com.dio.persistence.config;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.sql.SQLException;

import static lombok.AccessLevel.PRIVATE;

public final class ConnectionConfig {

    private ConnectionConfig() {
        // Private constructor to prevent instantiation
    }

    public static Jdbi getJdbi() {
        var url = "jdbc:mysql://localhost/board";
        var user = "board";
        var password = "board";

        Jdbi jdbi = Jdbi.create(url, user, password);
        jdbi.installPlugin(new SqlObjectPlugin());
        return jdbi;
    }
}

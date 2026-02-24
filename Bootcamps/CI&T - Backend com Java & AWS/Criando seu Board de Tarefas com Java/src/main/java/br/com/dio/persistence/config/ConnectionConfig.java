package br.com.dio.persistence.config;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import static lombok.AccessLevel.PRIVATE;

public final class ConnectionConfig {

    private static final String DB_URL_ENV = "DB_URL";
    private static final String DB_USER_ENV = "DB_USER";
    private static final String DB_PASSWORD_ENV = "DB_PASSWORD";

    private ConnectionConfig() {
        // Private constructor to prevent instantiation
    }

    public static Jdbi getJdbi() {
        String dbUrl = System.getenv(DB_URL_ENV);
        String dbUser = System.getenv(DB_USER_ENV);
        String dbPassword = System.getenv(DB_PASSWORD_ENV);

        // Provide default values for local development if environment variables are not set
        if (dbUrl == null || dbUrl.isEmpty()) {
            dbUrl = "jdbc:mysql://localhost/board";
        }
        if (dbUser == null || dbUser.isEmpty()) {
            dbUser = "board";
        }
        if (dbPassword == null || dbPassword.isEmpty()) {
            dbPassword = "board";
        }

        Jdbi jdbi = Jdbi.create(dbUrl, dbUser, dbPassword);
        jdbi.installPlugin(new SqlObjectPlugin());
        return jdbi;
    }
}

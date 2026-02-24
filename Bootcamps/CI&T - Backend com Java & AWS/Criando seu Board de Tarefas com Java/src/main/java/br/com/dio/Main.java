package br.com.dio;

import br.com.dio.persistence.migration.MigrationStrategy;
import br.com.dio.ui.MainMenu;

import org.jdbi.v3.core.Jdbi;

import static br.com.dio.persistence.config.ConnectionConfig.getJdbi;


public class Main {

    public static void main(String[] args) {
        Jdbi jdbi = getJdbi(); // Get the Jdbi instance once
        new MigrationStrategy(jdbi).executeMigration(); // Pass Jdbi instance
        new MainMenu(jdbi).execute(); // Pass Jdbi instance
    }

}

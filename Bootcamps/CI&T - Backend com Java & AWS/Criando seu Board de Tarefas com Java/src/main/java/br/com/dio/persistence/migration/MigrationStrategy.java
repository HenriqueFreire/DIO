package br.com.dio.persistence.migration;

import liquibase.Liquibase;
import liquibase.database.jvm.JdbcConnection;
import liquibase.exception.LiquibaseException;
import liquibase.resource.ClassLoaderResourceAccessor;
import lombok.AllArgsConstructor;
import org.jdbi.v3.core.Jdbi;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.Connection;
// import java.sql.SQLException; // REMOVED

@AllArgsConstructor
public class MigrationStrategy {

    private final Jdbi jdbi;

    public void executeMigration(){
        var originalOut = System.out;
        var originalErr = System.err;
        try(var fos = new FileOutputStream("liquibase.log")){
            System.setOut(new PrintStream(fos));
            System.setErr(new PrintStream(fos));
            try{
                jdbi.withHandle(handle -> {
                    Connection connection = handle.getConnection();
                    try(var jdbcConnection = new JdbcConnection(connection)){
                        var liquibase = new Liquibase(
                                "/db/changelog/db.changelog-master.yml",
                                new ClassLoaderResourceAccessor(),
                                jdbcConnection);
                        liquibase.update();
                    } catch (LiquibaseException e) { // SQLException removed
                        throw new RuntimeException(e); // JDBI will rollback on RuntimeException
                    }
                    return null; // Return null as withHandle requires a return
                });
            } catch (Exception e) { // Catch the RuntimeException wrapped by JDBI
                e.printStackTrace();
                System.setErr(originalErr);
            }
        } catch (IOException ex){
            ex.printStackTrace();
        } finally {
            System.setOut(originalOut);
            System.setErr(originalErr);
        }
    }

}

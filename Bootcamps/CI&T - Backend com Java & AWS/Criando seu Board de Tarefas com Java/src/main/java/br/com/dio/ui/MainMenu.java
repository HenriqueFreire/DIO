package br.com.dio.ui;

import br.com.dio.persistence.entity.BoardColumnEntity;
import br.com.dio.persistence.entity.BoardColumnKindEnum;
import br.com.dio.persistence.entity.BoardEntity;
import br.com.dio.service.BoardQueryService;
import br.com.dio.service.BoardService;
import org.jdbi.v3.core.Jdbi;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static br.com.dio.persistence.entity.BoardColumnKindEnum.CANCEL;
import static br.com.dio.persistence.entity.BoardColumnKindEnum.FINAL;
import static br.com.dio.persistence.entity.BoardColumnKindEnum.INITIAL;
import static br.com.dio.persistence.entity.BoardColumnKindEnum.PENDING;

public class MainMenu {

    private final Scanner scanner = new Scanner(System.in).useDelimiter("\n");
    private final Jdbi jdbi;

    public MainMenu(Jdbi jdbi) {
        this.jdbi = jdbi;
    }

    public void execute() {
        System.out.println("Bem vindo ao gerenciador de boards, escolha a opção desejada");
        var option = -1;
        while (true){
            System.out.println("1 - Criar um novo board");
            System.out.println("2 - Selecionar um board existente");
            System.out.println("3 - Excluir um board");
            System.out.println("4 - Sair");
            option = scanner.nextInt();
            try { // Centralized error handling
                switch (option){
                    case 1 -> createBoard();
                    case 2 -> selectBoard();
                    case 3 -> deleteBoard();
                    case 4 -> System.exit(0);
                    default -> System.out.println("Opção inválida, informe uma opção do menu");
                }
            } catch (RuntimeException ex) {
                System.err.println("Ocorreu um erro: " + ex.getMessage());
                // For a CLI, printing stack trace can be helpful for debugging
                // ex.printStackTrace();
            }
        }
    }

    private void createBoard() {
        var entity = new BoardEntity();
        System.out.println("Informe o nome do seu board");
        entity.setName(scanner.next());

        System.out.println("Seu board terá colunas além das 3 padrões? Se sim informe quantas, senão digite '0'");
        var additionalColumns = scanner.nextInt();

        List<BoardColumnEntity> columns = new ArrayList<>();

        System.out.println("Informe o nome da coluna inicial do board");
        var initialColumnName = scanner.next();
        var initialColumn = createColumn(initialColumnName, INITIAL, 0);
        columns.add(initialColumn);

        for (int i = 0; i < additionalColumns; i++) {
            System.out.println("Informe o nome da coluna de tarefa pendente do board");
            var pendingColumnName = scanner.next();
            var pendingColumn = createColumn(pendingColumnName, PENDING, i + 1);
            columns.add(pendingColumn);
        }

        System.out.println("Informe o nome da coluna final");
        var finalColumnName = scanner.next();
        var finalColumn = createColumn(finalColumnName, FINAL, additionalColumns + 1);
        columns.add(finalColumn);

        System.out.println("Informe o nome da coluna de cancelamento do baord");
        var cancelColumnName = scanner.next();
        var cancelColumn = createColumn(cancelColumnName, CANCEL, additionalColumns + 2);
        columns.add(cancelColumn);

        entity.setBoardColumns(columns);
        // Using Jdbi instance
        var service = new BoardService(jdbi);
        service.insert(entity);
    }

    private void selectBoard() {
        System.out.println("Informe o id do board que deseja selecionar");
        var id = scanner.nextLong();
        // Using Jdbi instance
        var queryService = new BoardQueryService(jdbi);
        var optional = queryService.findById(id);
        optional.ifPresentOrElse(
                b -> new BoardMenu(b, jdbi).execute(), // Pass Jdbi instance to BoardMenu
                () -> System.out.printf("Não foi encontrado um board com id %s\n", id)
        );
    }

    private void deleteBoard() {
        System.out.println("Informe o id do board que será excluido");
        var id = scanner.nextLong();
        // Using Jdbi instance
        var service = new BoardService(jdbi);
        if (service.delete(id)){
            System.out.printf("O board %s foi excluido\n", id);
        } else {
            System.out.printf("Não foi encontrado um board com id %s\n", id);
        }
    }

    private BoardColumnEntity createColumn(final String name, final BoardColumnKindEnum kind, final int order){
        var boardColumn = new BoardColumnEntity();
        boardColumn.setName(name);
        boardColumn.setKind(kind);
        boardColumn.setOrder(order);
        return boardColumn;
    }

}

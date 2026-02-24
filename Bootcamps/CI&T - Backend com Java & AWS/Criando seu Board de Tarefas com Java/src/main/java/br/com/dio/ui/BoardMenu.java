package br.com.dio.ui;

import br.com.dio.dto.BoardColumnInfoDTO;
import br.com.dio.persistence.entity.BoardColumnEntity;
import br.com.dio.persistence.entity.BoardEntity;
import br.com.dio.persistence.entity.CardEntity;
import br.com.dio.service.BoardColumnQueryService;
import br.com.dio.service.BoardQueryService;
import br.com.dio.service.CardQueryService;
import br.com.dio.service.CardService;
// import lombok.AllArgsConstructor; // REMOVED
import org.jdbi.v3.core.Jdbi;

// import java.sql.SQLException; // Removed, no longer directly thrown or caught
import java.util.Scanner;
import java.util.List; // Explicitly import List

// @AllArgsConstructor // REMOVED
public class BoardMenu {

    private final Scanner scanner = new Scanner(System.in).useDelimiter("\n");

    private final BoardEntity entity;
    private final Jdbi jdbi; // Inject Jdbi instance

    public BoardMenu(BoardEntity entity, Jdbi jdbi) {
        this.entity = entity;
        this.jdbi = jdbi;
    }

    public void execute() {
        System.out.printf("Bem vindo ao board %s, selecione a operação desejada\n", entity.getId());
        var option = -1;
        while (option != 9) {
            System.out.println("1 - Criar um card");
            System.out.println("2 - Mover um card");
            System.out.println("3 - Bloquear um card");
            System.out.println("4 - Desbloquear um card");
            System.out.println("5 - Cancelar um card");
            System.out.println("6 - Ver board");
            System.out.println("7 - Ver coluna com cards");
            System.out.println("8 - Ver card");
            System.out.println("9 - Voltar para o menu anterior");
            System.out.println("10 - Sair");
            option = scanner.nextInt();
            try { // Centralized error handling
                switch (option) {
                    case 1 -> createCard();
                    case 2 -> moveCardToNextColumn();
                    case 3 -> blockCard();
                    case 4 -> unblockCard();
                    case 5 -> cancelCard();
                    case 6 -> showBoard();
                    case 7 -> showColumn();
                    case 8 -> showCard();
                    case 9 -> System.out.println("Voltando para o menu anterior");
                    case 10 -> System.exit(0);
                    default -> System.out.println("Opção inválida, informe uma opção do menu");
                }
            } catch (RuntimeException ex) {
                System.err.println("Ocorreu um erro: " + ex.getMessage());
                // ex.printStackTrace(); // Optional: uncomment for detailed debugging
            }
        }
    }

    private void createCard(){
        var card = new CardEntity();
        System.out.println("Informe o título do card");
        card.setTitle(scanner.next());
        System.out.println("Informe a descrição do card");
        card.setDescription(scanner.next());
        card.setBoardColumn(entity.getInitialColumn());
        new CardService(jdbi).create(card); // Use Jdbi instance
    }

    private void moveCardToNextColumn() {
        System.out.println("Informe o id do card que deseja mover para a próxima coluna");
        var cardId = scanner.nextLong();
        var boardColumnsInfo = entity.getBoardColumns().stream()
                .map(bc -> new BoardColumnInfoDTO(bc.getId(), bc.getOrder(), bc.getKind()))
                .toList();
        new CardService(jdbi).moveToNextColumn(cardId, boardColumnsInfo); // Use Jdbi instance
    }

    private void blockCard() {
        System.out.println("Informe o id do card que será bloqueado");
        var cardId = scanner.nextLong();
        System.out.println("Informe o motivo do bloqueio do card");
        var reason = scanner.next();
        var boardColumnsInfo = entity.getBoardColumns().stream()
                .map(bc -> new BoardColumnInfoDTO(bc.getId(), bc.getOrder(), bc.getKind()))
                .toList();
        new CardService(jdbi).block(cardId, reason, boardColumnsInfo); // Use Jdbi instance
    }

    private void unblockCard() {
        System.out.println("Informe o id do card que será desbloqueado");
        var cardId = scanner.nextLong();
        System.out.println("Informe o motivo do desbloqueio do card");
        var reason = scanner.next();
        new CardService(jdbi).unblock(cardId, reason); // Use Jdbi instance
    }

    private void cancelCard() {
        System.out.println("Informe o id do card que deseja mover para a coluna de cancelamento");
        var cardId = scanner.nextLong();
        var cancelColumn = entity.getCancelColumn();
        var boardColumnsInfo = entity.getBoardColumns().stream()
                .map(bc -> new BoardColumnInfoDTO(bc.getId(), bc.getOrder(), bc.getKind()))
                .toList();
        new CardService(jdbi).cancel(cardId, cancelColumn.getId(), boardColumnsInfo); // Use Jdbi instance
    }

    private void showBoard() {
        var optional = new BoardQueryService(jdbi).showBoardDetails(entity.getId()); // Use Jdbi instance
        optional.ifPresent(b -> {
            System.out.printf("Board [%s,%s]\n", b.id(), b.name());
            b.columns().forEach(c ->
                    System.out.printf("Coluna [%s] tipo: [%s] tem %s cards\n", c.name(), c.kind(), c.cardsAmount())
            );
        });
    }

    private void showColumn() {
        var columnsIds = entity.getBoardColumns().stream().map(BoardColumnEntity::getId).toList();
        var selectedColumnId = -1L;
        while (!columnsIds.contains(selectedColumnId)){
            System.out.printf("Escolha uma coluna do board %s pelo id\n", entity.getName());
            entity.getBoardColumns().forEach(c -> System.out.printf("%s - %s [%s]\n", c.getId(), c.getName(), c.getKind()));
            selectedColumnId = scanner.nextLong();
        }
        var column = new BoardColumnQueryService(jdbi).findById(selectedColumnId); // Use Jdbi instance
        column.ifPresent(co -> {
            System.out.printf("Coluna %s tipo %s\n", co.getName(), co.getKind());
            co.getCards().forEach(ca -> System.out.printf("Card %s - %s\nDescrição: %s",
                    ca.getId(), ca.getTitle(), ca.getDescription()));
        });
    }

    private void showCard() {
        System.out.println("Informe o id do card que deseja visualizar");
        var selectedCardId = scanner.nextLong();
        new CardQueryService(jdbi).findById(selectedCardId) // Use Jdbi instance
                .ifPresentOrElse(
                        c -> {
                            System.out.printf("Card %s - %s.\n", c.id(), c.title());
                            System.out.printf("Descrição: %s\n", c.description());
                            System.out.println(c.blocked() ?
                                    "Está bloqueado. Motivo: " + c.blockReason() :
                                    "Não está bloqueado");
                            System.out.printf("Já foi bloqueado %s vezes\n", c.blocksAmount());
                            System.out.printf("Está no momento na coluna %s - %s\n", c.columnId(), c.columnName());
                        },
                        () -> System.out.printf("Não existe um card com o id %s\n", selectedCardId));
    }

}

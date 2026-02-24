package br.com.dio.service;

import br.com.dio.dto.CardDetailsDTO;
import br.com.dio.persistence.dao.CardDAO;
import lombok.AllArgsConstructor;
import org.jdbi.v3.core.Jdbi;

import java.util.Optional;

@AllArgsConstructor
public class CardQueryService {

    private final Jdbi jdbi;

    public Optional<CardDetailsDTO> findById(final Long id) { // Removed SQLException
        return jdbi.withHandle(handle -> {
            var cardDao = handle.attach(CardDAO.class);
            return cardDao.findById(id);
        });
    }

}

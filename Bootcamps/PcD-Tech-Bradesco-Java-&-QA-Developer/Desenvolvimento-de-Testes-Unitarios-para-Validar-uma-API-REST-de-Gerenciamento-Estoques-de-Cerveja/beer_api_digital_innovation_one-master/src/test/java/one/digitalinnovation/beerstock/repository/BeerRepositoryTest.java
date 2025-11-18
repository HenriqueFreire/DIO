package one.digitalinnovation.beerstock.repository;

import one.digitalinnovation.beerstock.entity.Beer;
import one.digitalinnovation.beerstock.enums.BeerType;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.Optional;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
public class BeerRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private BeerRepository beerRepository;

    @Test
    void whenFindByName_thenReturnBeer() {
        // given
        Beer beerToSave = Beer.builder()
                .name("Brahma")
                .brand("Ambev")
                .max(100)
                .quantity(10)
                .type(BeerType.LAGER)
                .build();

        entityManager.persist(beerToSave);

        // when
        Optional<Beer> foundBeerOptional = beerRepository.findByName(beerToSave.getName());

        // then
        assertTrue(foundBeerOptional.isPresent());
        assertThat(foundBeerOptional.get(), is(equalTo(beerToSave)));
    }

    @Test
    void whenFindByNameIsNotFound_thenReturnEmptyOptional() {
        // when
        Optional<Beer> foundBeerOptional = beerRepository.findByName("NonExistentBeer");

        // then
        assertFalse(foundBeerOptional.isPresent());
    }
}

package one.digitalinnovation.beerstock.mapper;

import one.digitalinnovation.beerstock.builder.BeerDTOBuilder;
import one.digitalinnovation.beerstock.dto.BeerDTO;
import one.digitalinnovation.beerstock.entity.Beer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class BeerMapperTest {

    private BeerMapper beerMapper = BeerMapper.INSTANCE;

    @Test
    void testDtoToModel() {
        // given
        BeerDTO beerDTO = BeerDTOBuilder.builder().build().toBeerDTO();
        
        // when
        Beer beer = beerMapper.toModel(beerDTO);

        // then
        assertEquals(beerDTO.getId(), beer.getId());
        assertEquals(beerDTO.getName(), beer.getName());
        assertEquals(beerDTO.getBrand(), beer.getBrand());
        assertEquals(beerDTO.getMax(), beer.getMax());
        assertEquals(beerDTO.getQuantity(), beer.getQuantity());
        assertEquals(beerDTO.getType(), beer.getType());
    }

    @Test
    void testModelToDto() {
        // given
        BeerDTO beerDTO = BeerDTOBuilder.builder().build().toBeerDTO();
        Beer beer = beerMapper.toModel(beerDTO);

        // when
        BeerDTO convertedBeerDTO = beerMapper.toDTO(beer);

        // then
        assertEquals(beer.getId(), convertedBeerDTO.getId());
        assertEquals(beer.getName(), convertedBeerDTO.getName());
        assertEquals(beer.getBrand(), convertedBeerDTO.getBrand());
        assertEquals(beer.getMax(), convertedBeerDTO.getMax());
        assertEquals(beer.getQuantity(), convertedBeerDTO.getQuantity());
        assertEquals(beer.getType(), convertedBeerDTO.getType());
    }
}

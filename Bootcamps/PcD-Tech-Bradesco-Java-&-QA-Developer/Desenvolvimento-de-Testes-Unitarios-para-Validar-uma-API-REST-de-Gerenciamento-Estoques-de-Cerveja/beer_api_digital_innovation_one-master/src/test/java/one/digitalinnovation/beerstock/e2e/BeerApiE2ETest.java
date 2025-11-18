package one.digitalinnovation.beerstock.e2e;

import io.restassured.RestAssured;
import one.digitalinnovation.beerstock.builder.BeerDTOBuilder;
import one.digitalinnovation.beerstock.dto.BeerDTO;
import one.digitalinnovation.beerstock.repository.BeerRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.MediaType;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class BeerApiE2ETest {

    @LocalServerPort
    private int port;

    @Autowired
    private BeerRepository beerRepository;

    @BeforeEach
    void setUp() {
        RestAssured.port = port;
        RestAssured.basePath = "/api/v1/beers";
    }

    @AfterEach
    void tearDown() {
        beerRepository.deleteAll();
    }

    @Test
    void shouldCreateAndThenFindBeer() {
        // given
        BeerDTO beerDTO = BeerDTOBuilder.builder().build().toBeerDTO();

        // when
        given()
                .contentType(MediaType.APPLICATION_JSON_VALUE)
                .body(beerDTO)
        .when()
                .post()
        .then()
                .statusCode(201);

        // then
        given()
        .when()
                .get("/{name}", beerDTO.getName())
        .then()
                .statusCode(200)
                .body("name", equalTo(beerDTO.getName()))
                .body("brand", equalTo(beerDTO.getBrand()));
    }
}

package Riachuelo.storefront.controller.response;

import java.math.BigDecimal;
import java.util.UUID;
import com.fasterxml.jackson.annotation.JsonProperty;

public record ProductSavedResponse(
    @JsonProperty("id")
    UUID id,
    @JsonProperty("name")
    String name,
    @JsonProperty("price")
    BigDecimal price
) {
}
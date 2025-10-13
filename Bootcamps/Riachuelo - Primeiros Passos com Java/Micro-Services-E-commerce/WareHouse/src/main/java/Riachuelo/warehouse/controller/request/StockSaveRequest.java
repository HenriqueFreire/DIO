package Riachuelo.warehouse.controller.request;

import java.math.BigDecimal;
import java.util.UUID;
import com.fasterxml.jackson.annotation.JsonProperty;

public record StockSaveRequest(
    @JsonProperty("amount")
    Long amount,
    @JsonProperty("boughtPrice")
    BigDecimal boughtPrice,
    @JsonProperty("soldPrice")
    BigDecimal soldPrice,
    @JsonProperty("productId")
    UUID productId
) {
}
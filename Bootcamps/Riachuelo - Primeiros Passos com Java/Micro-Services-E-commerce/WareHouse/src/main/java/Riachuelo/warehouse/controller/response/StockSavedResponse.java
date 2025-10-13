package Riachuelo.warehouse.controller.response;

import java.math.BigDecimal;
import java.util.UUID;
import com.fasterxml.jackson.annotation.JsonProperty;
import Riachuelo.warehouse.entity.StockStatus;

public record StockSavedResponse(
    @JsonProperty("id")
    UUID id,
    @JsonProperty("amount")
    Long amount,
    @JsonProperty("boughtPrice")
    BigDecimal boughtPrice,
    @JsonProperty("status")
    StockStatus status,
    @JsonProperty("soldPrice")
    BigDecimal soldPrice,
    @JsonProperty("productId")
    UUID productId,
    @JsonProperty("productName")
    String productName
) {
}
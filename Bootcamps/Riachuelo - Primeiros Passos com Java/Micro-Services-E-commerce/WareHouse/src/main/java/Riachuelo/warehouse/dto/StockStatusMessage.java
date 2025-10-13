package Riachuelo.warehouse.dto;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonProperty;

import Riachuelo.warehouse.entity.StockStatus;

public record StockStatusMessage(
    @JsonProperty("id")
    UUID id,
    @JsonProperty("status")
    StockStatus status
) {
}
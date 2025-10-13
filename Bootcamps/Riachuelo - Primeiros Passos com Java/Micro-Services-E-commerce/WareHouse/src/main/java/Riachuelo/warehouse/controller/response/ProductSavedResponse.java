package Riachuelo.warehouse.controller.response;

import java.util.UUID;
import com.fasterxml.jackson.annotation.JsonProperty;

public record ProductSavedResponse(
    @JsonProperty("id")
    UUID id,
    @JsonProperty("name")
    String name
) {   
}
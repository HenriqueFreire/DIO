package Riachuelo.storefront.controller.request;

import java.util.UUID;
import com.fasterxml.jackson.annotation.JsonProperty;

public record ProductSaveRequest(
    @JsonProperty("id")
    UUID id,
    @JsonProperty("name")
    String name
) {
}
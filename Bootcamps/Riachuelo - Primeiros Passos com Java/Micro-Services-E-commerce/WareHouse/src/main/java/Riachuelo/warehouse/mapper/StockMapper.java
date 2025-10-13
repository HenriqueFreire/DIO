package Riachuelo.warehouse.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import Riachuelo.warehouse.controller.request.StockSaveRequest;
import Riachuelo.warehouse.controller.response.StockSavedResponse;
import Riachuelo.warehouse.entity.StockEntity;

import static org.mapstruct.MappingConstants.ComponentModel.SPRING;

@Mapper(componentModel = SPRING)
public interface StockMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "product.id", source = "productId")
    @Mapping(target = "status", expression = "java(Riachuelo.warehouse.entity.StockStatus.IN_CONFERENCE)")
    StockEntity toEntity(final StockSaveRequest request);

    @Mapping(target = "productId", source = "product.id")
    @Mapping(target = "productName", source = "product.name")
    StockSavedResponse toSavedResponse(final StockEntity entity);
}
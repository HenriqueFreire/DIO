package Riachuelo.warehouse.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import Riachuelo.warehouse.controller.request.ProductSaveRequest;
import Riachuelo.warehouse.controller.response.ProductDetailResponse;
import Riachuelo.warehouse.controller.response.ProductSavedResponse;
import Riachuelo.warehouse.dto.ProductStorefrontSaveDTO;
import Riachuelo.warehouse.entity.ProductEntity;

import static org.mapstruct.MappingConstants.ComponentModel.SPRING;

@Mapper(componentModel = SPRING)
public interface ProductMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "stocks", ignore = true)
    @Mapping(target = "price", ignore = true)
    ProductEntity toEntity(final ProductSaveRequest request);

    ProductSavedResponse toSavedResponse(final ProductEntity entity);

    @Mapping(target = "active", constant = "false")
    ProductStorefrontSaveDTO toDTO(final ProductEntity entity);
    
    ProductDetailResponse toDetailResponse(final ProductEntity entity);
}
package Riachuelo.storefront.mapper;

import java.math.BigDecimal;
import java.util.List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import Riachuelo.storefront.controller.request.ProductSaveRequest;
import Riachuelo.storefront.controller.response.ProductAvailableResponse;
import Riachuelo.storefront.controller.response.ProductDetailResponse;
import Riachuelo.storefront.controller.response.ProductSavedResponse;
import Riachuelo.storefront.dto.ProductInfoDTO;
import Riachuelo.storefront.entity.ProductEntity;
import static org.mapstruct.MappingConstants.ComponentModel.SPRING;

@Mapper(componentModel = SPRING)
public interface ProductMapper {
   
    ProductInfoDTO toDTO(final ProductEntity entity, final BigDecimal price);

    @Mapping(target = "active", constant = "false")
    ProductEntity toEntity(final ProductSaveRequest request);
    ProductSavedResponse toResponse(final ProductEntity entity);
    List<ProductAvailableResponse> toResponse(final List<ProductEntity> entities);
    ProductDetailResponse toResponse(final ProductInfoDTO dto);
}
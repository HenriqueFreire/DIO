package Riachuelo.storefront.service;

import java.util.List;
import java.util.UUID;
import Riachuelo.storefront.dto.ProductInfoDTO;
import Riachuelo.storefront.entity.ProductEntity;

public interface ProductService {

    ProductEntity save(final ProductEntity entity);
    void changeActivated(final UUID id, final boolean active);
    List<ProductEntity> findAllActive();
    ProductInfoDTO findInfo(final UUID id);
    void purchase(final UUID id);
}
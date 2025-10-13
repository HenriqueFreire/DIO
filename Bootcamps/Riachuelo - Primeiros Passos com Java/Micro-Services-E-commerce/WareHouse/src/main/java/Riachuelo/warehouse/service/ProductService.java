package Riachuelo.warehouse.service;

import java.util.UUID;
import Riachuelo.warehouse.entity.ProductEntity;

public interface ProductService {
    
    ProductEntity save(final ProductEntity entity);

    void purchase(final UUID id);
}
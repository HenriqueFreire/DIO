package Riachuelo.warehouse.service;

import java.util.UUID;
import Riachuelo.warehouse.entity.ProductEntity;

public interface ProductQueryService {
    
    ProductEntity findById(final UUID id);
}
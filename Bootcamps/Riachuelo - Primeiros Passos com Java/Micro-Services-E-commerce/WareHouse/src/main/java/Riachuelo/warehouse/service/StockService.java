package Riachuelo.warehouse.service;

import java.util.UUID;
import Riachuelo.warehouse.entity.StockEntity;
import Riachuelo.warehouse.entity.StockStatus;

public interface StockService {
    
    StockEntity save(final StockEntity entity);

    void release(final UUID id);

    void inactive(final UUID id);

    void changeStatus(final UUID id, final StockStatus status);
}
package Riachuelo.warehouse.service;

import Riachuelo.warehouse.dto.StockStatusMessage;

public interface ProductChangeAvailabilityProducer {
    
    void notifyStatusChange(final StockStatusMessage mensage);
}
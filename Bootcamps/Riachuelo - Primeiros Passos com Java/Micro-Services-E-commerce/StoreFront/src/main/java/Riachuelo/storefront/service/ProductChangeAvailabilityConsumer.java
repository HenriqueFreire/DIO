package Riachuelo.storefront.service;

import Riachuelo.storefront.dto.StockStatusMessage;

public interface ProductChangeAvailabilityConsumer {

    void receive(final StockStatusMessage message);
}
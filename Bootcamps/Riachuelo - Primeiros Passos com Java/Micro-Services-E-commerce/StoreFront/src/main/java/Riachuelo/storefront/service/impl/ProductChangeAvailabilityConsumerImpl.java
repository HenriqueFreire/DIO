package Riachuelo.storefront.service.impl;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;
import Riachuelo.storefront.dto.StockStatusMessage;
import Riachuelo.storefront.service.ProductChangeAvailabilityConsumer;
import Riachuelo.storefront.service.ProductService;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class ProductChangeAvailabilityConsumerImpl implements ProductChangeAvailabilityConsumer {

    private final ProductService service;

    @RabbitListener(queues = "${spring.rabbitmq.queue.product-change-availability}")
    @Override
    public void receive(final StockStatusMessage message) {
        service.changeActivated(message.id(), message.active());
    }
}
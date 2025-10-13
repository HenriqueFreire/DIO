package Riachuelo.warehouse.service.impl;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import Riachuelo.warehouse.dto.StockStatusMessage;
import Riachuelo.warehouse.service.ProductChangeAvailabilityProducer;

@Service
public class ProductChangeAvailabilityProducerImpl implements ProductChangeAvailabilityProducer {

    private final RabbitTemplate rabbitTemplate;
    private final String exchangeName;
    private final String routingKeyName;

    public ProductChangeAvailabilityProducerImpl(final RabbitTemplate rabbitTemplate,
                                                 @Value("${spring.rabbitmq.exchange.product-change-availability}") 
                                                 final String exchangeName,
                                                 @Value("${spring.rabbitmq.routing-key.product-change-availability}")
                                                 final String routingKeyName) {
        this.rabbitTemplate = rabbitTemplate;
        this.exchangeName = exchangeName;
        this.routingKeyName = routingKeyName;
    }

    @Override
    public void notifyStatusChange(StockStatusMessage mensage) {
        rabbitTemplate.convertAndSend(exchangeName, routingKeyName, mensage);
    }
}
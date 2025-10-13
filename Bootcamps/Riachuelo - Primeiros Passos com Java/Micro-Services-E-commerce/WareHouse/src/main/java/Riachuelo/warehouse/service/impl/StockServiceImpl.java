package Riachuelo.warehouse.service.impl;

import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import Riachuelo.warehouse.dto.StockStatusMessage;
import Riachuelo.warehouse.entity.StockEntity;
import Riachuelo.warehouse.entity.StockStatus;
import Riachuelo.warehouse.repository.StockRepository;
import Riachuelo.warehouse.service.ProductChangeAvailabilityProducer;
import Riachuelo.warehouse.service.ProductQueryService;
import Riachuelo.warehouse.service.StockService;
import lombok.AllArgsConstructor;

import static Riachuelo.warehouse.entity.StockStatus.*;


@Service
@AllArgsConstructor
public class StockServiceImpl implements StockService{

    private final StockRepository repository;
    private final ProductQueryService productQueryService;
    private final ProductChangeAvailabilityProducer producer;


    @Override
    public StockEntity save(StockEntity entity) {
        entity.setProduct(productQueryService.findById(entity.getProduct().getId()));
        return repository.save(entity);
    }

    @Override
    public void release(UUID id) {
        changeStatus(id, AVAILABLE);
    }

    @Override
    public void inactive(UUID id) {
        changeStatus(id, UNAVAILABLE);
    }

    @Override
    public void changeStatus(UUID id, StockStatus status) {
        var entity = repository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Stock not found with id " + id));
        entity.setStatus(status);
        repository.save(entity);
        producer.notifyStatusChange(new StockStatusMessage(entity.getProduct().getId(), status));
    }
}
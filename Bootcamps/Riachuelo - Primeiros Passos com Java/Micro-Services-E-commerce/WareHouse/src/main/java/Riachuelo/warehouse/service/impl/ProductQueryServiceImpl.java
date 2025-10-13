package Riachuelo.warehouse.service.impl;

import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import Riachuelo.warehouse.entity.ProductEntity;
import Riachuelo.warehouse.repository.ProductRepository;
import Riachuelo.warehouse.service.ProductQueryService;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductQueryServiceImpl implements ProductQueryService {

    private final ProductRepository repository;

    @Override
    public ProductEntity findById(UUID id) {
        return repository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found with id " + id));
    }
}
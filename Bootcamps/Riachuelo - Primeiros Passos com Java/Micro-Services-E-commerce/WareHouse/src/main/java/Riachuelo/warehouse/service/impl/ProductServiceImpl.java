package Riachuelo.warehouse.service.impl;

import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;
import Riachuelo.warehouse.dto.ProductStorefrontSaveDTO;
import Riachuelo.warehouse.entity.ProductEntity;
import Riachuelo.warehouse.mapper.ProductMapper;
import Riachuelo.warehouse.repository.ProductRepository;
import Riachuelo.warehouse.service.ProductQueryService;
import Riachuelo.warehouse.service.ProductService;
import Riachuelo.warehouse.service.StockService;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository repository;
    private final ProductQueryService productQueryService;
    private final StockService stockService;
    private final RestClient storefrontClient;
    private final ProductMapper mapper;

    @Override
    public ProductEntity save(ProductEntity entity) {
        repository.save(entity);
        var dto = mapper.toDTO(entity);
        saveStorefront(dto);
        return entity;  
    }

    @Override
    public void purchase(UUID id) {
        var entity = productQueryService.findById(id);
        var stock = entity.decStock();
        repository.save(entity);
        if (stock.isUnavailable()){
            stockService.changeStatus(entity.getId(), stock.getStatus());
        }
    }

    private void saveStorefront(final ProductStorefrontSaveDTO dto) {
        storefrontClient.post()
            .uri("/products")
            .body(dto)
            .retrieve()
            .body(ProductStorefrontSaveDTO.class);
    }
}
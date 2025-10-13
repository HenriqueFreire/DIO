package Riachuelo.storefront.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;
import org.springframework.web.server.ResponseStatusException;

import Riachuelo.storefront.dto.ProductDetailsDTO;
import Riachuelo.storefront.dto.ProductInfoDTO;
import Riachuelo.storefront.entity.ProductEntity;
import Riachuelo.storefront.mapper.ProductMapper;
import Riachuelo.storefront.repository.ProductRepository;
import Riachuelo.storefront.service.ProductService;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository repository;
    private final RestClient warehouseClient;
    private final ProductMapper mapper;
    
    @Override
    public ProductEntity save(final ProductEntity entity){
        return repository.save(entity);
    }

    @Override
    public void changeActivated(final UUID id, final boolean active) {
        var entity = repository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found with id " + id));
        entity.setActive(active);
        repository.save(entity);
    }

    @Override
    public List<ProductEntity> findAllActive(){
        return repository.findByActiveTrueOrderByNameAsc();
    }

    @Override
    public ProductInfoDTO findInfo(UUID id) {
        var entity = repository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found with id " + id));
        var price = requestCurrentAmount(id);
        return mapper.toDTO(entity, price);
    }

    @Override
    public void purchase(UUID id) {
        // Primeiro, verificamos se o produto existe no banco de dados do storefront
        repository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found with id " + id));
        
        // Se existir, chamamos o serviço do warehouse
        purchaseWarehouse(id);
    }
    
    private BigDecimal requestCurrentAmount(UUID id) {
        try {
            var dto = warehouseClient.get()
                .uri("/products/" + id)
                .retrieve()
                .body(ProductDetailsDTO.class);
            return dto.price();
        } catch (Exception e) {
            // Se o warehouse retornar um erro (como 404), queremos refletir isso no storefront
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error communicating with warehouse service", e);
        }
    }

    private void purchaseWarehouse(final UUID id){
        try {
            var path = String.format("/products/%s/purchase", id);
            warehouseClient.post()
                .uri(path)
                .retrieve()
                .toBodilessEntity();
        } catch (Exception e) {
            // Se o warehouse retornar um erro, queremos refletir isso no storefront
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error communicating with warehouse service", e);
        }
    }
}
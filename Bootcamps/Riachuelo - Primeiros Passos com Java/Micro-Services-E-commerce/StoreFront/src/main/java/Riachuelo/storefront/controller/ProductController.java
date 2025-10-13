package Riachuelo.storefront.controller;

import java.util.List;
import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import Riachuelo.storefront.controller.request.ProductSaveRequest;
import Riachuelo.storefront.controller.response.ProductAvailableResponse;
import Riachuelo.storefront.controller.response.ProductDetailResponse;
import Riachuelo.storefront.controller.response.ProductSavedResponse;
import Riachuelo.storefront.mapper.ProductMapper;
import Riachuelo.storefront.service.ProductService;
import lombok.AllArgsConstructor;
import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("products")
@AllArgsConstructor
public class ProductController {
    
    private final ProductService service;
    private final ProductMapper mapper;

    @PostMapping
    @ResponseStatus(CREATED)
    ProductSavedResponse create(@RequestBody final ProductSaveRequest request){
        var entity = mapper.toEntity(request);
        entity = service.save(entity);
        return mapper.toResponse(entity);
    }

    @PostMapping("{id}/purchase")
    @ResponseStatus(NO_CONTENT)
    void purchase(@PathVariable final UUID id){
        service.purchase(id);
    }

    @GetMapping
    List<ProductAvailableResponse> listAvailable(){
        var entities = service.findAllActive();
        return mapper.toResponse(entities);
    }

    @GetMapping("{id}")
    ProductDetailResponse findById(@PathVariable final UUID id){
        var dto = service.findInfo(id);
        return mapper.toResponse(dto);
    }
}
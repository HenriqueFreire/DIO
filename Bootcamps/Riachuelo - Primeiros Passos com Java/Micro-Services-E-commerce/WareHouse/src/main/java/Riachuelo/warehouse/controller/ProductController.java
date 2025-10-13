package Riachuelo.warehouse.controller;

import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import Riachuelo.warehouse.controller.request.ProductSaveRequest;
import Riachuelo.warehouse.controller.response.ProductDetailResponse;
import Riachuelo.warehouse.controller.response.ProductSavedResponse;
import Riachuelo.warehouse.mapper.ProductMapper;
import Riachuelo.warehouse.service.ProductQueryService;
import Riachuelo.warehouse.service.ProductService;
import lombok.AllArgsConstructor;

import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("products")
@AllArgsConstructor
public class ProductController {
    
    private final ProductService service;
    private final ProductQueryService queryService;
    private final ProductMapper mapper;

    @PostMapping
    @ResponseStatus(CREATED)
    ProductSavedResponse create(@RequestBody final ProductSaveRequest request){
        var entity = mapper.toEntity(request);
        entity = service.save(entity);
        return mapper.toSavedResponse(entity);
    }

    @PostMapping("{id}/purchase")
    @ResponseStatus(NO_CONTENT)
    void purchase(@PathVariable final UUID id){
        service.purchase(id);
    }

    @GetMapping("{id}")
    @ResponseStatus(NO_CONTENT)
    ProductDetailResponse findById(@PathVariable final UUID id){
        var dto = queryService.findById(id);
        return mapper.toDetailResponse(dto);
    }
}
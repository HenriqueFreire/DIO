package Riachuelo.warehouse.controller;

import java.util.UUID;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import Riachuelo.warehouse.controller.request.StockSaveRequest;
import Riachuelo.warehouse.controller.response.StockSavedResponse;
import Riachuelo.warehouse.mapper.StockMapper;
import Riachuelo.warehouse.service.StockService;
import lombok.AllArgsConstructor;

import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("stocks")
@AllArgsConstructor
public class StockController {
    
    private final StockService service;
    private final StockMapper mapper;

    @PostMapping
    @ResponseStatus(CREATED)
    StockSavedResponse save(@RequestBody final StockSaveRequest request){
        var entity = mapper.toEntity(request);
        entity = service.save(entity);
        return mapper.toSavedResponse(entity);
    }

    @PutMapping("{id}/release")
    @ResponseStatus(NO_CONTENT)
    void release(@PathVariable final UUID id){
        service.release(id);
    }

    @DeleteMapping("{id}/release")
    @ResponseStatus(NO_CONTENT)
    void inactive(@PathVariable final UUID id){
        service.inactive(id);
    }
}
package Riachuelo.warehouse.repository;

import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import Riachuelo.warehouse.entity.StockEntity;

@Repository
public interface StockRepository extends JpaRepository<StockEntity, UUID>{
    
}
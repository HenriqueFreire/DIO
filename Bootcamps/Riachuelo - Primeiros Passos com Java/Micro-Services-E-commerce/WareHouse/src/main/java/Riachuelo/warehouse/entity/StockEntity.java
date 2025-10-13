package Riachuelo.warehouse.entity;

import java.math.BigDecimal;
import java.util.Objects;
import java.util.UUID;
import jakarta.persistence.Entity;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import static jakarta.persistence.EnumType.STRING;
import static Riachuelo.warehouse.entity.StockStatus.UNAVAILABLE;

@Entity
@Getter
@Setter
@ToString
public class StockEntity {
    
    @Id
    private UUID id;
    private Long amount;
    private BigDecimal boughtPrice;

    @Enumerated(STRING)
    private StockStatus status;

    private BigDecimal soldPrice;

    public void decAmount(){
        this.amount -= 1;
        if (this.amount == 0) {
            this.status = UNAVAILABLE;
        }
    }

    public boolean isUnavailable(){
        return status == UNAVAILABLE;
    }

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private ProductEntity product;

    @PrePersist
    private void prePersist() {
        this.id = UUID.randomUUID();
    }

    @Override
    public boolean equals(final Object o){
        if (!(o instanceof StockEntity that)) return false;
        return  Objects.equals(id, that.id) && 
                Objects.equals(amount, that.amount) && 
                Objects.equals(boughtPrice, that.boughtPrice) && 
                status == that.status && 
                Objects.equals(soldPrice, that.soldPrice);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, amount, boughtPrice, status, soldPrice);
    }
}
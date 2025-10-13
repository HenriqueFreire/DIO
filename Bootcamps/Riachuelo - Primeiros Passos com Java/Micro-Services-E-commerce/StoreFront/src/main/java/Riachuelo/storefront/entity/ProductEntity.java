package Riachuelo.storefront.entity;

import java.util.Objects;
import java.util.UUID;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString
public class ProductEntity {
    
    @Id
    private UUID id;
    private String name;
    private Boolean active;

    @Override
    public boolean equals(final Object o){
        if (!(o instanceof ProductEntity that)) return false;
        return Objects.equals(id, that.id) && 
                Objects.equals(name, that.name) && 
                Objects.equals(active, that.active);
    }

    @Override
    public int hashCode(){
        return Objects.hash(id, name, active);
    }
}
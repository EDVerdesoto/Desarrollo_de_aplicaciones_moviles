package ec.edu.espe.pedidos_api.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Setter
@Getter
public class OrderDetailDTO {

    private String product;
    private int amount;
    private Double unitPrice;

}

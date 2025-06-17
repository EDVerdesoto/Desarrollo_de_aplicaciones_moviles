package ec.edu.espe.pedidos_api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String product;
    private int amount;
    private Double unitPrice;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order orderId;

}

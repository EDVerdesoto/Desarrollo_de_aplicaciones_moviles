package ec.edu.espe.pedidos_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ec.edu.espe.pedidos_api.model.Order;

public interface OrderRepository extends JpaRepository<Order, Long>{

}

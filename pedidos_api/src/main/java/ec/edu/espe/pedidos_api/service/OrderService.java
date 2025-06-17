package ec.edu.espe.pedidos_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ec.edu.espe.pedidos_api.repository.OrderRepository;
import ec.edu.espe.pedidos_api.model.Order;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public List<Order> getOrders(){
        return this.orderRepository.findAll();
    }

    

}

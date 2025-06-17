package ec.edu.espe.pedidos_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ec.edu.espe.pedidos_api.repository.OrderRepository;
import ec.edu.espe.pedidos_api.model.Order;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public List<Order> getOrders(){
        return this.orderRepository.findAll();
    }

    public Optional<Order> getOrderById(Long id){
        return this.orderRepository.findById(id);
    }

    public Order createOrder(Order order){
        return this.orderRepository.save(order);
    }

}

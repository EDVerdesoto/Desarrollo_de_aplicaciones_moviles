package ec.edu.espe.pedidos_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ec.edu.espe.pedidos_api.model.OrderDetail;
import ec.edu.espe.pedidos_api.repository.OrderDetailRepository;

@Service
public class OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public OrderDetail addDetails(OrderDetail orderDetail){
        return this.orderDetailRepository.save(orderDetail);
    }

}

package ec.edu.espe.pedidos_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ec.edu.espe.pedidos_api.model.OrderDetail;
import ec.edu.espe.pedidos_api.dtos.OrderDetailDTO;
import ec.edu.espe.pedidos_api.repository.OrderDetailRepository;
import ec.edu.espe.pedidos_api.repository.OrderRepository;

@Service
public class OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private OrderRepository orderRepository;

    public OrderDetail addDetails(Long orderId, OrderDetailDTO orderDetailDTO){
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setProduct(orderDetailDTO.getProduct());
        orderDetail.setAmount(orderDetailDTO.getAmount());
        orderDetail.setUnitPrice(orderDetailDTO.getUnitPrice());
        orderDetail.setOrderId(this.orderRepository.findById(orderId).get());
        return this.orderDetailRepository.save( orderDetail);
    }

}

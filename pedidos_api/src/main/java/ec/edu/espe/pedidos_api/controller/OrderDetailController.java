package ec.edu.espe.pedidos_api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ec.edu.espe.pedidos_api.dtos.OrderDetailDTO;
import ec.edu.espe.pedidos_api.model.OrderDetail;
import ec.edu.espe.pedidos_api.service.OrderDetailService;


@RestController
@RequestMapping("/api/orderDetails")
public class OrderDetailController {

    @Autowired
    private OrderDetailService orderDetailService;

    @PostMapping("/{orderId}")
    public ResponseEntity<OrderDetail> crear(@PathVariable Long orderId, @RequestBody OrderDetailDTO orderDetail) {
        return ResponseEntity.ok(this.orderDetailService.addDetails(orderId, orderDetail));
    }

}

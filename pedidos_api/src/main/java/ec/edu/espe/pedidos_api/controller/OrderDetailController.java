package ec.edu.espe.pedidos_api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ec.edu.espe.pedidos_api.model.OrderDetail;
import ec.edu.espe.pedidos_api.service.OrderDetailService;


@RestController
@RequestMapping("/api/orderDetails")
public class OrderDetailController {

    @Autowired
    private OrderDetailService orderDetailService;

    @PostMapping
    public ResponseEntity<OrderDetail> crear(@RequestBody OrderDetail orderDetail) {
        return ResponseEntity.ok(this.orderDetailService.addDetails(orderDetail));
    }

}

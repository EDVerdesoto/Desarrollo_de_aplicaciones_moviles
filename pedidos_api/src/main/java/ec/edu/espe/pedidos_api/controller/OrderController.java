package ec.edu.espe.pedidos_api.controller;

import ec.edu.espe.pedidos_api.model.OrderDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ec.edu.espe.pedidos_api.service.OrderService;
import ec.edu.espe.pedidos_api.model.Order;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    @GetMapping
    public List<Order> getOrders() {
        return this.orderService.getOrders();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id) {
        return this.orderService.getOrderById(id).
            map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Order> createOrder(@RequestBody Order order) {
        return ResponseEntity.ok(this.orderService.createOrder(order));
    }
    @PostMapping("/{orderId}/details")
    public ResponseEntity<OrderDetail> addDetail(
            @PathVariable Long orderId,
            @RequestBody OrderDetail detail) {

        OrderDetail saved = orderDetailService.addDetails(orderId, detail);
        return ResponseEntity.status(HttpStatus.CREATED).body(saved);
    }
}

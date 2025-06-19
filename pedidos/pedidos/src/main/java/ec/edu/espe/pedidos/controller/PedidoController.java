package ec.edu.espe.pedidos.controller;


import ec.edu.espe.pedidos.dto.DetallePedidoDto;
import ec.edu.espe.pedidos.dto.PedidoDto;
import ec.edu.espe.pedidos.service.PedidoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pedidos")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class PedidoController {

    private final PedidoService pedidoService;

    @GetMapping
    public ResponseEntity<List<PedidoDto>> getAllPedidos() {
        log.info("GET /api/pedidos - Obteniendo todos los pedidos");
        List<PedidoDto> pedidos = pedidoService.findAll();
        return ResponseEntity.ok(pedidos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PedidoDto> getPedidoById(@PathVariable Long id) {
        log.info("GET /api/pedidos/{} - Obteniendo pedido por ID", id);
        PedidoDto pedido = pedidoService.findById(id);
        return ResponseEntity.ok(pedido);
    }

    @PostMapping
    public ResponseEntity<PedidoDto> createPedido(@Valid @RequestBody PedidoDto pedidoDto) {
        log.info("POST /api/pedidos - Creando nuevo pedido");
        PedidoDto createdPedido = pedidoService.create(pedidoDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdPedido);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PedidoDto> updatePedido(@PathVariable Long id,
                                                  @Valid @RequestBody PedidoDto pedidoDto) {
        log.info("PUT /api/pedidos/{} - Actualizando pedido", id);
        PedidoDto updatedPedido = pedidoService.update(id, pedidoDto);
        return ResponseEntity.ok(updatedPedido);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePedido(@PathVariable Long id) {
        log.info("DELETE /api/pedidos/{} - Eliminando pedido", id);
        pedidoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/detalles")
    public ResponseEntity<PedidoDto> addDetalleToPedido(@PathVariable Long id,
                                                        @Valid @RequestBody DetallePedidoDto detallePedidoDto) {
        log.info("POST /api/pedidos/{}/detalles - Agregando detalle al pedido", id);
        PedidoDto updatedPedido = pedidoService.addDetalleToPedido(id, detallePedidoDto);
        return ResponseEntity.ok(updatedPedido);
    }

    @GetMapping("/{id}/detalles")
    public ResponseEntity<List<DetallePedidoDto>> getDetallesByPedido(@PathVariable Long id) {
        log.info("GET /api/pedidos/{}/detalles - Obteniendo detalles del pedido", id);
        List<DetallePedidoDto> detalles = pedidoService.getDetallesByPedidoId(id);
        return ResponseEntity.ok(detalles);
    }
}
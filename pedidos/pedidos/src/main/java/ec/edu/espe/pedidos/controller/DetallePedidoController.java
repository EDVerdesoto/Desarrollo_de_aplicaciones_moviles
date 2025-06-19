package ec.edu.espe.pedidos.controller;


import ec.edu.espe.pedidos.dto.DetallePedidoDto;
import ec.edu.espe.pedidos.service.DetallePedidoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/detalles")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*")
public class DetallePedidoController {

    private final DetallePedidoService detallePedidoService;

    @GetMapping
    public ResponseEntity<List<DetallePedidoDto>> getAllDetalles() {
        log.info("GET /api/detalles - Obteniendo todos los detalles");
        List<DetallePedidoDto> detalles = detallePedidoService.findAll();
        return ResponseEntity.ok(detalles);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetallePedidoDto> getDetalleById(@PathVariable Long id) {
        log.info("GET /api/detalles/{} - Obteniendo detalle por ID", id);
        DetallePedidoDto detalle = detallePedidoService.findById(id);
        return ResponseEntity.ok(detalle);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DetallePedidoDto> updateDetalle(@PathVariable Long id,
                                                          @Valid @RequestBody DetallePedidoDto detallePedidoDto) {
        log.info("PUT /api/detalles/{} - Actualizando detalle", id);
        DetallePedidoDto updatedDetalle = detallePedidoService.update(id, detallePedidoDto);
        return ResponseEntity.ok(updatedDetalle);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDetalle(@PathVariable Long id) {
        log.info("DELETE /api/detalles/{} - Eliminando detalle", id);
        detallePedidoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
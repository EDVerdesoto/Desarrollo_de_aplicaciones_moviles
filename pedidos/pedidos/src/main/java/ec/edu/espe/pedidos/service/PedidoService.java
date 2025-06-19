package ec.edu.espe.pedidos.service;


import ec.edu.espe.pedidos.dto.PedidoDto;
import ec.edu.espe.pedidos.dto.DetallePedidoDto;

import java.util.List;

public interface PedidoService {

    List<PedidoDto> findAll();

    PedidoDto findById(Long id);

    PedidoDto create(PedidoDto pedidoDto);

    PedidoDto update(Long id, PedidoDto pedidoDto);

    void deleteById(Long id);

    PedidoDto addDetalleToPedido(Long pedidoId, DetallePedidoDto detallePedidoDto);

    List<DetallePedidoDto> getDetallesByPedidoId(Long pedidoId);
}
package ec.edu.espe.pedidos.service.impl;


import ec.edu.espe.pedidos.dto.DetallePedidoDto;
import ec.edu.espe.pedidos.dto.PedidoDto;
import ec.edu.espe.pedidos.mapper.PedidoMapper;
import ec.edu.espe.pedidos.model.DetallePedido;
import ec.edu.espe.pedidos.model.Pedido;
import ec.edu.espe.pedidos.repository.DetallePedidoRepository;
import ec.edu.espe.pedidos.repository.PedidoRepository;
import ec.edu.espe.pedidos.service.PedidoService;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class PedidoServiceImpl implements PedidoService {

    private final PedidoRepository pedidoRepository;
    private final DetallePedidoRepository detallePedidoRepository;
    private final PedidoMapper pedidoMapper;

    @Override
    public List<PedidoDto> findAll() {
        log.debug("Obteniendo todos los pedidos");
        List<Pedido> pedidos = pedidoRepository.findAllWithDetalles();
        return pedidoMapper.toDtoList(pedidos);
    }

    @Override
    public PedidoDto findById(Long id) {
        log.debug("Obteniendo pedido por ID: {}", id);
        Pedido pedido = pedidoRepository.findByIdWithDetalles(id)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado con ID: " + id));
        return pedidoMapper.toDto(pedido);
    }

    @Override
    @Transactional
    public PedidoDto create(PedidoDto pedidoDto) {
        log.debug("Creando nuevo pedido para cliente: {}", pedidoDto.getCliente());
        Pedido pedido = pedidoMapper.toEntity(pedidoDto);
        Pedido savedPedido = pedidoRepository.save(pedido);
        return pedidoMapper.toDto(savedPedido);
    }

    @Override
    @Transactional
    public PedidoDto update(Long id, PedidoDto pedidoDto) {
        log.debug("Actualizando pedido con ID: {}", id);
        Pedido existingPedido = pedidoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado con ID: " + id));

        existingPedido.setCliente(pedidoDto.getCliente());
        existingPedido.setFecha(pedidoDto.getFecha());

        Pedido updatedPedido = pedidoRepository.save(existingPedido);
        return pedidoMapper.toDto(updatedPedido);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        log.debug("Eliminando pedido con ID: {}", id);
        if (!pedidoRepository.existsById(id)) {
            throw new RuntimeException("Pedido no encontrado con ID: " + id);
        }
        pedidoRepository.deleteById(id);
    }

    @Override
    @Transactional
    public PedidoDto addDetalleToPedido(Long pedidoId, DetallePedidoDto detallePedidoDto) {
        log.debug("Agregando detalle al pedido ID: {}", pedidoId);
        Pedido pedido = pedidoRepository.findById(pedidoId)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado con ID: " + pedidoId));

        DetallePedido detalle = pedidoMapper.detallePedidoToEntity(detallePedidoDto);
        pedido.addDetalle(detalle);

        Pedido savedPedido = pedidoRepository.save(pedido);
        return pedidoMapper.toDto(savedPedido);
    }

    @Override
    public List<DetallePedidoDto> getDetallesByPedidoId(Long pedidoId) {
        log.debug("Obteniendo detalles del pedido ID: {}", pedidoId);
        if (!pedidoRepository.existsById(pedidoId)) {
            throw new RuntimeException("Pedido no encontrado con ID: " + pedidoId);
        }

        List<DetallePedido> detalles = detallePedidoRepository.findByPedidoId(pedidoId);
        return pedidoMapper.detallePedidoToDtoList(detalles);
    }
}
package ec.edu.espe.pedidos.service.impl;


import ec.edu.espe.pedidos.dto.DetallePedidoDto;
import ec.edu.espe.pedidos.mapper.PedidoMapper;
import ec.edu.espe.pedidos.model.DetallePedido;
import ec.edu.espe.pedidos.repository.DetallePedidoRepository;
import ec.edu.espe.pedidos.service.DetallePedidoService;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class DetallePedidoServiceImpl implements DetallePedidoService {

    private final DetallePedidoRepository detallePedidoRepository;
    private final PedidoMapper pedidoMapper;

    @Override
    public List<DetallePedidoDto> findAll() {
        log.debug("Obteniendo todos los detalles de pedido");
        List<DetallePedido> detalles = detallePedidoRepository.findAll();
        return pedidoMapper.detallePedidoToDtoList(detalles);
    }

    @Override
    public DetallePedidoDto findById(Long id) {
        log.debug("Obteniendo detalle de pedido por ID: {}", id);
        DetallePedido detalle = detallePedidoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Detalle de pedido no encontrado con ID: " + id));
        return pedidoMapper.detallePedidoToDto(detalle);
    }

    @Override
    @Transactional
    public DetallePedidoDto update(Long id, DetallePedidoDto detallePedidoDto) {
        log.debug("Actualizando detalle de pedido con ID: {}", id);
        DetallePedido existingDetalle = detallePedidoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Detalle de pedido no encontrado con ID: " + id));

        existingDetalle.setProducto(detallePedidoDto.getProducto());
        existingDetalle.setCantidad(detallePedidoDto.getCantidad());
        existingDetalle.setPrecioUnitario(detallePedidoDto.getPrecioUnitario());

        DetallePedido updatedDetalle = detallePedidoRepository.save(existingDetalle);
        return pedidoMapper.detallePedidoToDto(updatedDetalle);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        log.debug("Eliminando detalle de pedido con ID: {}", id);
        if (!detallePedidoRepository.existsById(id)) {
            throw new RuntimeException("Detalle de pedido no encontrado con ID: " + id);
        }
        detallePedidoRepository.deleteById(id);
    }

    @Override
    public List<DetallePedidoDto> findByPedidoId(Long pedidoId) {
        log.debug("Obteniendo detalles por pedido ID: {}", pedidoId);
        List<DetallePedido> detalles = detallePedidoRepository.findByPedidoId(pedidoId);
        return pedidoMapper.detallePedidoToDtoList(detalles);
    }
}
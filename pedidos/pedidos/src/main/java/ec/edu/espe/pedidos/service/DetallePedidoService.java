package ec.edu.espe.pedidos.service;


import ec.edu.espe.pedidos.dto.DetallePedidoDto;

import java.util.List;

public interface DetallePedidoService {

    List<DetallePedidoDto> findAll();

    DetallePedidoDto findById(Long id);

    DetallePedidoDto update(Long id, DetallePedidoDto detallePedidoDto);

    void deleteById(Long id);

    List<DetallePedidoDto> findByPedidoId(Long pedidoId);
}
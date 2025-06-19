package ec.edu.espe.pedidos.repository;

import ec.edu.espe.pedidos.model.DetallePedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DetallePedidoRepository extends JpaRepository<DetallePedido, Long> {

    List<DetallePedido> findByPedidoId(Long pedidoId);

    @Query("SELECT d FROM DetallePedido d WHERE d.pedido.id = :pedidoId")
    List<DetallePedido> findDetallesByPedidoId(@Param("pedidoId") Long pedidoId);

    List<DetallePedido> findByProductoContainingIgnoreCase(String producto);

    void deleteByPedidoId(Long pedidoId);
}
package ec.edu.espe.pedidos.repository;

import ec.edu.espe.pedidos.model.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Long> {

    @Query("SELECT p FROM Pedido p LEFT JOIN FETCH p.detalles WHERE p.id = :id")
    Optional<Pedido> findByIdWithDetalles(@Param("id") Long id);

    @Query("SELECT p FROM Pedido p LEFT JOIN FETCH p.detalles")
    List<Pedido> findAllWithDetalles();

    List<Pedido> findByClienteContainingIgnoreCase(String cliente);

    List<Pedido> findByFechaBetween(LocalDate fechaInicio, LocalDate fechaFin);
}
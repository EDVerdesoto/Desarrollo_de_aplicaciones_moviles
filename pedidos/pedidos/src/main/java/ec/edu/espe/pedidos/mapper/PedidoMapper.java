package ec.edu.espe.pedidos.mapper;

import ec.edu.espe.pedidos.model.DetallePedido;
import ec.edu.espe.pedidos.model.Pedido;
import ec.edu.espe.pedidos.dto.DetallePedidoDto;
import ec.edu.espe.pedidos.dto.PedidoDto;

import org.mapstruct.*;

import java.util.List;

@Mapper(
        componentModel = "spring",
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE,
        unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public interface PedidoMapper {

    @Mapping(target = "detalles", source = "detalles")
    PedidoDto toDto(Pedido pedido);

   @Mapping(target = "detalles", ignore = true)
    Pedido toEntity(PedidoDto pedidoDto);

    List<PedidoDto> toDtoList(List<Pedido> pedidos);

    @Mapping(target = "pedidoId", source = "pedido.id")
    @Mapping(target = "subtotal", expression = "java(detallePedido.getSubtotal())")
    DetallePedidoDto detallePedidoToDto(DetallePedido detallePedido);

    @Mapping(target = "pedido", ignore = true)
    DetallePedido detallePedidoToEntity(DetallePedidoDto detallePedidoDto);

    List<DetallePedidoDto> detallePedidoToDtoList(List<DetallePedido> detalles);

    @AfterMapping
    default void setDetallesRelation(@MappingTarget Pedido pedido, PedidoDto pedidoDto) {
        if (pedido.getDetalles() != null) {
            pedido.getDetalles().forEach(detalle -> detalle.setPedido(pedido));
        }
    }
}
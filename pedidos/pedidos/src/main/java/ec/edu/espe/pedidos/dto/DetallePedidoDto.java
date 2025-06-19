package ec.edu.espe.pedidos.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class DetallePedidoDto {

    private Long id;

    @NotBlank(message = "El producto es obligatorio")
    @Size(min = 2, max = 100, message = "El producto debe tener entre 2 y 100 caracteres")
    private String producto;

    @NotNull(message = "La cantidad es obligatoria")
    @Min(value = 1, message = "La cantidad debe ser mayor a 0")
    @Max(value = 1000, message = "La cantidad no puede ser mayor a 1000")
    private Integer cantidad;

    @NotNull(message = "El precio unitario es obligatorio")
    @DecimalMin(value = "0.01", message = "El precio debe ser mayor a 0")
    @Digits(integer = 8, fraction = 2, message = "El precio debe tener máximo 8 dígitos enteros y 2 decimales")
    private BigDecimal precioUnitario;

    private Long pedidoId;

    private BigDecimal subtotal;
}
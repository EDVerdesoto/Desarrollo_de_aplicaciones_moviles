package ec.edu.espe.pedidos.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class PedidoDto {

    private Long id;

    @NotBlank(message = "El cliente es obligatorio")
    @Size(min = 2, max = 100, message = "El cliente debe tener entre 2 y 100 caracteres")
    private String cliente;

    @NotNull(message = "La fecha es obligatoria")
    private LocalDate fecha;

    private List<DetallePedidoDto> detalles;
}
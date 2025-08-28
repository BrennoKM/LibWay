package com.spring.libway.model;

import com.spring.libway.enums.StatusLocacao;
import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.OffsetDateTime;

@Data
@Entity
@Table(name = "locacoes")
public class Locacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "cliente_id", nullable = false)
    private Usuario cliente;

    @ManyToOne
    @JoinColumn(name = "catalogo_id", nullable = false)
    private CatalogoLocador itemCatalogo;

    private OffsetDateTime dataLocacao;

    private OffsetDateTime dataDevolucao;

    @Enumerated(EnumType.STRING)
    private StatusLocacao status;

    @Column(nullable = false)
    private BigDecimal valorSinal;

    private BigDecimal valorFinal;
}
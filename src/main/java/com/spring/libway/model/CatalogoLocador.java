package com.spring.libway.model;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "catalogos_locador")
public class CatalogoLocador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "locador_id", nullable = false)
    private Usuario locador;

    @ManyToOne
    @JoinColumn(name = "obra_id", nullable = false)
    private Obra obra;

    @Column(nullable = false)
    private Integer estoque;

    @Column(nullable = false)
    private BigDecimal valorAluguel;
}
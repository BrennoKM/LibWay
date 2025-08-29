package com.spring.libway.model;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Data
@Entity
@Table(name = "depositos")
public class Deposito {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    @Column(nullable = false)
    private BigDecimal valor;

    @Column(name = "metodo_pagamento", nullable = false)
    private String metodoPagamento;

    @Column(name = "data_deposito")
    private OffsetDateTime dataDeposito;

    public String getDataDepositoFormatada() {
        if (this.dataDeposito == null) {
            return "";
        }
        ZoneId fusoHorarioBrasil = ZoneId.of("America/Sao_Paulo");
        DateTimeFormatter formatador = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");
        return this.dataDeposito.atZoneSameInstant(fusoHorarioBrasil).format(formatador);
    }
}
package com.spring.libway.model;

import com.spring.libway.enums.StatusLocacao;
import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

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

    public String getDataLocacaoFormatada() {
        if (this.dataLocacao == null) {
            return "";
        }
        ZoneId fusoHorarioBrasil = ZoneId.of("America/Sao_Paulo");
        DateTimeFormatter formatador = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");

        return this.dataLocacao.atZoneSameInstant(fusoHorarioBrasil).format(formatador);
    }

    public String getDataDevolucaoFormatada() {
        if (this.dataDevolucao == null) {
            return "";
        }
        ZoneId fusoHorarioBrasil = ZoneId.of("America/Sao_Paulo");
        DateTimeFormatter formatador = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");

        return this.dataDevolucao.atZoneSameInstant(fusoHorarioBrasil).format(formatador);
    }

    public BigDecimal getValorTotalAluguel() {
        if (this.valorSinal == null) {
            return BigDecimal.ZERO;
        }
        return this.valorSinal.multiply(new BigDecimal("2"));
    }

    // valor final é igual ao inicial (50% do total)
    public BigDecimal getValorRestante() {
        return this.valorSinal;
    }

}
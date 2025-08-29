package com.spring.libway.model;

import com.spring.libway.enums.TipoUsuario;
import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Data
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;

    @Column(unique = true)
    @JsonIgnore
    private String email;

    @JsonIgnore
    private String senha;

    @Enumerated(EnumType.STRING)
    @JsonIgnore
    private TipoUsuario tipoUsuario;

    @JsonIgnore
    private BigDecimal saldo = BigDecimal.ZERO;

    @Column(unique = true)
    @JsonIgnore
    private String cpf;

    @Column(unique = true)
    @JsonIgnore
    private String cnpj;
}
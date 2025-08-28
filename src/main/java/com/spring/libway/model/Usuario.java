package com.spring.libway.model;

import com.spring.libway.enums.TipoUsuario;
import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;

    @Column(unique = true)
    private String email;

    private String senha;

    @Enumerated(EnumType.STRING)
    private TipoUsuario tipoUsuario;

    private BigDecimal saldo;

    @Column(unique = true)
    private String cpf;

    @Column(unique = true)
    private String cnpj;
}
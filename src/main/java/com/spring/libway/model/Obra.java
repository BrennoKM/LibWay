package com.spring.libway.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "obras")
public class Obra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String isbn;

    @Column(nullable = false)
    private String titulo;

    private String autor;

    private String editora;

    @Column(nullable = false)
    private String resumoCompleto;

    private String sumario;

    private String textoCompleto;

}

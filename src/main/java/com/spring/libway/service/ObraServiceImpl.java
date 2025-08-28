package com.spring.libway.service;

import com.spring.libway.model.Obra;
import com.spring.libway.repository.ObraRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ObraServiceImpl implements ObraService {

    @Autowired
    private ObraRepository obraRepository;

    @Override
    public Obra salvarObra(Obra obra) {
        Optional<Obra> obraExistente = obraRepository.findByIsbn(obra.getIsbn());

        if (obraExistente.isPresent()) {
            throw new IllegalStateException("Obra com ISBN " + obra.getIsbn() + " já existe.");
        }

        return obraRepository.save(obra);
    }

    @Override
    public List<Obra> listarTodas() {
        return obraRepository.findAll();
    }

    @Override
    public Optional<Obra> buscarPorId(Long id) {
        return obraRepository.findById(id);
    }

    @Override
    public Optional<Obra> buscarPorIsbn(String isbn) {
        return obraRepository.findByIsbn(isbn);
    }
}
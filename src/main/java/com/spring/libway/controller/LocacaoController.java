package com.spring.libway.controller;

import com.spring.libway.service.LocacaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/locacoes")
public class LocacaoController {

    @Autowired
    private LocacaoService locacaoService;

    @PostMapping("/alugar")
    public String alugarLivro(@RequestParam Long catalogoId, RedirectAttributes redirectAttributes) {
        try {
            locacaoService.realizarLocacao(catalogoId);
            redirectAttributes.addFlashAttribute("successMessage", "Livro alugado com sucesso! O valor do sinal foi debitado do seu saldo.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro ao alugar livro: " + e.getMessage());
        }

        return "redirect:/cliente/home";
    }
}
package com.spring.libway.controller;

import com.spring.libway.model.Obra;
import com.spring.libway.service.ObraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/obras")
public class ObraController {

    @Autowired
    private ObraService obraService;

    @GetMapping("/cadastrar")
    public String mostrarFormularioCadastro(Model model) {
        model.addAttribute("obra", new Obra());

        return "obra/form-cadastro";
    }

    @PostMapping("/cadastrar")
    public String salvarObra(@ModelAttribute("obra") Obra obra, RedirectAttributes redirectAttributes) {

        try {
            obraService.salvarObra(obra);
            redirectAttributes.addFlashAttribute("successMessage", "Obra cadastrada com sucesso!");

            return "redirect:/obras/listar";

        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());

            return "redirect:/obras/cadastrar";
        }
    }
}
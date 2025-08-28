package com.spring.libway.controller;

import com.spring.libway.model.Usuario;
import com.spring.libway.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/registrar")
    public String mostrarFormularioDeRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());

        return "registrar";
    }

    @PostMapping("/registrar")
    public String processarRegistro(@ModelAttribute("usuario") Usuario usuario) {
        usuarioService.salvarUsuario(usuario);

        return "redirect:/login";
    }

    @GetMapping("/login")
    public String mostrarFormularioDeLogin() {
        return "login";
    }
}
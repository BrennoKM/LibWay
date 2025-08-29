package com.spring.libway.controller;

import com.spring.libway.model.CatalogoLocador;
import com.spring.libway.model.Locacao;
import com.spring.libway.model.Obra;
import com.spring.libway.model.Usuario;
import com.spring.libway.service.CatalogoLocadorService;
import com.spring.libway.service.LocacaoService;
import com.spring.libway.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.math.BigDecimal;

import java.util.List;

@Controller
@RequestMapping("/locador")
public class LocadorController {

    @Autowired
    private CatalogoLocadorService catalogoLocadorService;

    @Autowired
    private LocacaoService locacaoService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/home")
    public String mostrarHomeLocador(Model model) {
        Usuario locador = usuarioService.getUsuarioLogado();
        model.addAttribute("locador", locador);
        List<CatalogoLocador> catalogoPessoal = catalogoLocadorService.listarCatalogoDoLocadorLogado();
        model.addAttribute("catalogoPessoal", catalogoPessoal);
        model.addAttribute("obra", new Obra());

        return "locador/home";
    }

    @PostMapping("/catalogo/adicionar")
    public String adicionarObraAoCatalogo(@RequestParam Long obraId,
                                          @RequestParam Integer estoque,
                                          @RequestParam BigDecimal valorAluguel,
                                          RedirectAttributes redirectAttributes) {

        try {
            catalogoLocadorService.adicionarObraAoCatalogo(obraId, estoque, valorAluguel);
            redirectAttributes.addFlashAttribute("successMessage", "Obra adicionada ao seu catálogo com sucesso!");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/obras/lista";
    }

    @GetMapping("/painel")
    public String mostrarPainelLocador(Model model) {
        List<Locacao> locacoesAtivas = locacaoService.listarLocacoesAtivasDoLocadorLogado();
        List<Locacao> locacoesFinalizadas = locacaoService.listarLocacoesFinalizadasDoLocadorLogado();

        model.addAttribute("locacoesAtivas", locacoesAtivas);
        model.addAttribute("locacoesFinalizadas", locacoesFinalizadas);

        return "locador/painel";
    }

    @PostMapping("/catalogo/alterar")
    public String alterarItemCatalogo(
            @RequestParam("id") Long id,
            @RequestParam("estoque") Integer estoque,
            @RequestParam("valorAluguel") BigDecimal valorAluguel) {

        catalogoLocadorService.atualizarItemCatalogo(id, estoque, valorAluguel);
        return "redirect:/locador/home";
    }

}
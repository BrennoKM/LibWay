package com.spring.libway.controller;

import com.spring.libway.enums.StatusLocacao;
import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;
import com.spring.libway.service.LocacaoService;
import com.spring.libway.service.UsuarioService;
import com.spring.libway.service.CatalogoLocadorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/cliente")
public class ClienteController {
    private static final Logger logger = LoggerFactory.getLogger(ClienteController.class);
    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private LocacaoService locacaoService;

    @Autowired
    private CatalogoLocadorService catalogoLocadorService;

    @GetMapping("/home")
    public String mostrarHomeCliente(Model model) {
        Usuario cliente = usuarioService.getUsuarioLogado();
        List<Locacao> locacoesAtivas = locacaoService.listarLocacoesAtivasDoClienteLogado();
        List<Locacao> locacoesFinalizadas = locacaoService.listarLocacoesFinalizadasDoClienteLogado();

        model.addAttribute("cliente", cliente);
        model.addAttribute("locacoes", locacoesAtivas); // Locações ativas
        model.addAttribute("locacoesFinalizadas", locacoesFinalizadas); // Locações finalizadas

        return "cliente/home";
    }

    @PostMapping("/saldo/adicionar")
    public String adicionarSaldo(@RequestParam BigDecimal valor,
                                 @RequestParam String metodoPagamento,
                                 RedirectAttributes redirectAttributes) {
        try {
            usuarioService.adicionarSaldo(valor, metodoPagamento);
            redirectAttributes.addFlashAttribute("successMessage", "Saldo adicionado com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/cliente/home";
    }

    @GetMapping("/vitrine")
    public String mostrarVitrine(Model model) {
        model.addAttribute("itensDeCatalogo", catalogoLocadorService.listarItensDisponiveisParaAluguel());

        return "cliente/vitrine";
    }

    @GetMapping("/locacao/{id}/detalhes")
    @ResponseBody
    public Locacao getDetalhesLocacao(@PathVariable Long id) {
        Locacao locacao = locacaoService.buscarPorIdDoClienteLogado(id);

        if (locacao.getStatus() == StatusLocacao.FINALIZADA) {
            var obra = locacao.getItemCatalogo().getObra();
            if (obra != null) {
                obra.setSumario(null);
                obra.setTextoCompleto(null);
            }
        }

        return locacao;
    }

    @PostMapping("/devolver/{id}")
    public String devolverLivro(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            locacaoService.devolverLivro(id);
            redirectAttributes.addFlashAttribute("successMessage", "Livro devolvido e locação finalizada com sucesso!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erro na devolução: " + e.getMessage());
        }
        return "redirect:/cliente/home";
    }

}
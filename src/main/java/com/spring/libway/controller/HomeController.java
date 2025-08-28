package com.spring.libway.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Authentication authentication) {
        String userRole = authentication.getAuthorities().stream()
                .findFirst()
                .map(GrantedAuthority::getAuthority)
                .orElse("");

        if ("ROLE_LOCADOR".equals(userRole)) {
            return "redirect:/locador/home";
        } else if ("ROLE_CLIENTE".equals(userRole)) {
            return "redirect:/cliente/home";
        }

        return "redirect:/login";
    }
}
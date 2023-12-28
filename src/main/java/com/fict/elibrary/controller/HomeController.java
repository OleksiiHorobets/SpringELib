package com.fict.elibrary.controller;

import jakarta.annotation.security.PermitAll;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {
    @GetMapping({"home", ""})
    @PermitAll
    public String home() {
        return "common/index";
    }
}

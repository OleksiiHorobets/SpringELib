package com.fict.elibrary.controller;

import com.fict.elibrary.dto.auth.AuthRequest;
import jakarta.annotation.security.PermitAll;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @GetMapping("/api/login")
    @PermitAll
    public String loginRequest(/*@Valid @RequestParam AuthRequest authRequest*/) {

        return "login-page";
    }
}

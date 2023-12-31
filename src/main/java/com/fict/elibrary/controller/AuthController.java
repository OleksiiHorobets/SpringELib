package com.fict.elibrary.controller;

import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.exception.UserAlreadyExistsException;
import com.fict.elibrary.service.ELibUserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final ELibUserService userService;

    @GetMapping("/auth/login")
    public String loginRequest() {
        return "common/login-page";
    }

    @PostMapping(value = "/auth/register", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String register(Model model, @Valid RegistrationRequest registrationRequest, HttpSession session) throws UserAlreadyExistsException {
        session.setAttribute("regUser", registrationRequest);
        userService.register(registrationRequest);
        model.addAttribute("regMsg", "success");
        session.setAttribute("username", registrationRequest.getUsername());
        return "common/login-page";
    }


}

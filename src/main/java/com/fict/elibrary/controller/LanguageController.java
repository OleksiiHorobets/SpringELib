package com.fict.elibrary.controller;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequestMapping("/language")
public class LanguageController {

    @PostMapping
    public ResponseEntity<Object> changeLanguagePost(@RequestParam String language, HttpSession session) {
        log.info("Language is set to: {}; For session: {}", language, session.getId());
        session.setAttribute("language", language);

        return ResponseEntity.ok().build();
    }
}

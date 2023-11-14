package com.fict.elibrary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/book")
public class BookController {
//    private final BookService bookService;

    @GetMapping("")
    public String getAll(Model model) {
        return "index";
    }
}

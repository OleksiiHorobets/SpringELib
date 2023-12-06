package com.fict.elibrary.controller;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.service.BookService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
@RequestMapping("/books")
@RequiredArgsConstructor
public class BookController {
    private final BookService bookService;

    @GetMapping
    public String getAll(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "10", required = false) int pageSize,
            @RequestParam(name = "order_by", defaultValue = "title", required = false) String sortField,
            @RequestParam(name = "dir", defaultValue = "asc", required = false) String sortDirection,
            Model model,
            HttpSession session
    ) {
        log.info("Books List: User with session id: {}", session.getId());
        var sort = Sort.by(Sort.Direction.fromString(sortDirection), sortField);
        var pageRequest = PageRequest.of(pageNumber, pageSize, sort);

        model.addAttribute("order_by", sortField);
        model.addAttribute("dir", sortDirection);
        model.addAttribute("booksList", bookService.findAll(pageRequest));
        return "books";
    }

    @GetMapping("/rest")
    @ResponseBody
    public Page<BookDto> getAllRest(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "15", required = false) int pageSize,
            @RequestParam(name = "sort", defaultValue = "title", required = false) String sortField,
            @RequestParam(name = "dir", defaultValue = "asc", required = false) String sortDirection,
            Model model
    ) {
        var pageRequest = PageRequest.of(pageNumber, pageSize, Sort.by(Sort.Direction.fromString(sortDirection), sortField));

        return bookService.findAll(pageRequest);
    }
}

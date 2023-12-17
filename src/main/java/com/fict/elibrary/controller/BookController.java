package com.fict.elibrary.controller;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.enums.Search;
import com.fict.elibrary.service.BookService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Pattern;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
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
            @RequestParam(name = "size", defaultValue = "15", required = false) int pageSize,
            @RequestParam(name = "orderBy", defaultValue = "title", required = false) String sortField,
            @RequestParam(name = "dir", defaultValue = "asc", required = false) String sortDirection,
            Model model,
            HttpSession session
    ) {
        log.info("Books List: User with session id: {}", session.getId());
        var sort = Sort.by(Sort.Direction.fromString(sortDirection), sortField);
        var pageRequest = PageRequest.of(pageNumber, pageSize, sort);


        model.addAttribute("orderBy", sortField);
        model.addAttribute("dir", sortDirection);
        model.addAttribute("booksList", bookService.findAll(resolveIfIncludeRemoved(), pageRequest));
        return "books";
    }

    @GetMapping("/search")
    public String searchAll(
            @RequestParam(name = "searchBy") @Valid @Pattern(regexp = "\\b(?:by_title|by_author)\\b") String searchBy,
            @RequestParam(name = "searchContent", defaultValue = "") String searchContent,
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "15", required = false) int pageSize,
            @RequestParam(name = "orderBy", defaultValue = "title", required = false) String sortField,
            @RequestParam(name = "dir", defaultValue = "asc", required = false) String sortDirection,
            Model model,
            HttpSession session
    ) {
        log.info("Books search: user with session id: {}", session.getId());
        var sort = Sort.by(Sort.Direction.fromString(sortDirection), sortField);
        var pageRequest = PageRequest.of(pageNumber, pageSize, sort);

        Page<BookDto> books = findAllBooksByCriteria(searchBy, searchContent, pageRequest);

        model.addAttribute("searchBy", searchBy);
        model.addAttribute("searchContent", searchContent);
        model.addAttribute("orderBy", sortField);
        model.addAttribute("dir", sortDirection);
        model.addAttribute("booksList", books);
        return "books";
    }

    private Page<BookDto> findAllBooksByCriteria(String searchBy, String searchContent, PageRequest pageRequest) {
        boolean includeRemoved = resolveIfIncludeRemoved();

        Page<BookDto> bookDtos = Page.empty();
        if (searchBy.equalsIgnoreCase(Search.BY_AUTHOR.toString())) {
            bookDtos = bookService.findAllByAuthorName(includeRemoved, searchContent, pageRequest);
        } else if (searchBy.equalsIgnoreCase(Search.BY_TITLE.toString())) {
            bookDtos = bookService.findAllByTitle(includeRemoved, searchContent, pageRequest);
        }
        return bookDtos;
    }

    private boolean resolveIfIncludeRemoved() {
        return SecurityContextHolder.getContext()
                .getAuthentication()
                .getAuthorities()
                .stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"));
    }

    @GetMapping("/rest")
    @ResponseBody
    public Page<BookDto> getAllRest(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "15", required = false) int pageSize,
            @RequestParam(name = "orderBy", defaultValue = "title", required = false) String sortField,
            @RequestParam(name = "dir", defaultValue = "asc", required = false) String sortDirection
    ) {
        var pageRequest = PageRequest.of(pageNumber, pageSize, Sort.by(Sort.Direction.fromString(sortDirection), sortField));

        return bookService.findAll(true, pageRequest);
    }


}

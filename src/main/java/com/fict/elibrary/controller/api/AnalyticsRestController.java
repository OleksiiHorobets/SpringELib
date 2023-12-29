package com.fict.elibrary.controller.api;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.entity.Genre;
import com.fict.elibrary.service.BookService;
import com.fict.elibrary.service.GenreService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/analytics")
public class AnalyticsRestController {
    private final GenreService genreService;

    @GetMapping("/books-distribution")
    public Map<Genre, Long> getGenresDistributionByBooks() {
        return genreService.getBookDistributionByGenres();
    }
}

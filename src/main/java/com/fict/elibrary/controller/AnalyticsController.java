package com.fict.elibrary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/analytics")
public class AnalyticsController {
    @GetMapping
    public String getAnalyticsPage() {
        return "admin/analytics";
    }
}

package com.fict.elibrary.controller;

import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.service.ELibUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import static com.fict.elibrary.utils.UserUtils.resolveUserId;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/users")
public class UserController {
    private final ELibUserService userService;

    @GetMapping
    public String getAllUsers(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "5", required = false) int pageSize,
            Model model
    ) {

        log.info("Get all users list: by admin with id {}", SecurityContextHolder.getContext().getAuthentication().getName());

        var pageRequest = PageRequest.of(pageNumber, pageSize);

        model.addAttribute("usersList", userService.findAll(pageRequest));
        return "admin/display_users";
    }

    @GetMapping("/profile")
    public String displayProfile(Model model) throws ResourceNotFoundException {
        model.addAttribute("user", userService.findByIdToDto(resolveUserId()));


        return "user/profile";
    }
}

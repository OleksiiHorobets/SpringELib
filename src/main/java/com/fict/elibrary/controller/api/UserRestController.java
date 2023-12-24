package com.fict.elibrary.controller.api;

import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.service.ELibUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users/")
@Slf4j
@RequiredArgsConstructor
public class UserRestController {
    private final ELibUserService userService;

    @PatchMapping("{userId}")
    @ResponseStatus(HttpStatus.OK)
    public void changeStatus(
            @PathVariable Long userId,
            @RequestParam(name = "isBanned") Boolean isBanned,
            HttpSession session
    ) throws ResourceNotFoundException {
        userService.setUserBlockedStatus(userId, isBanned);
    }

//    @Autowired
//    private FindByIndexNameSessionRepository<? extends Session> sessionRepository;
//
//    public void invalidateSessionForBlockedUser(String username) {
//        Map<String, ? extends Session> sessions = sessionRepository.findByPrincipalName(username);
//
//        for (Session session : sessions.values()) {
//            sessionRepository.deleteById(session.getId());
//        }
//    }
}

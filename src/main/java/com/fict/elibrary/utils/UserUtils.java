package com.fict.elibrary.utils;

import com.fict.elibrary.entity.ELibUser;
import lombok.experimental.UtilityClass;
import org.springframework.security.core.context.SecurityContextHolder;

@UtilityClass
public class UserUtils {
    public static ELibUser resolveAuthenticatedUser() {
        var authentication = SecurityContextHolder.getContext().getAuthentication();
        return (ELibUser) authentication.getPrincipal();
    }

    public static long resolveUserId() {
        return resolveAuthenticatedUser().getId();
    }
}

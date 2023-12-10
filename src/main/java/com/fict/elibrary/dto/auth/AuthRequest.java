package com.fict.elibrary.dto.auth;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthRequest {
    @NotNull(message = "Username must not be null!")
    @Size(min = 3, message = "Username must be at least 3 chars long!")
    private String username;

    @NotNull(message = "Password must not be null!")
    private String password;
}

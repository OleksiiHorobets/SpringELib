package com.fict.elibrary.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(jsr250Enabled = true, securedEnabled = true, prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {
    private final UserDetailsService eLibUserService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
//                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authz ->
                                authz
                                        .requestMatchers("/api/**").hasRole("ADMIN")
                                        .requestMatchers("/auth/**", "/home").permitAll()
                                        .requestMatchers("/pages/common/**", "/pages/error**").permitAll()
                                        .requestMatchers("/pages/admin/**").hasAnyRole("ADMIN")
                                        .requestMatchers("/pages/user/**").hasAnyRole("USER", "ADMIN")
                                        .requestMatchers("/language").permitAll()
                                        .requestMatchers("/static/**").permitAll()
                                        .requestMatchers("/books/**").permitAll()
                                        .anyRequest().authenticated()
//                                .anyRequest().permitAll()
                ).formLogin(
                        form -> form.loginPage("/auth/login")
                                .loginProcessingUrl("/login")
                                .defaultSuccessUrl("/home")
                                .failureUrl("/auth/login?invalidAuth=true")
                                .permitAll()
                );

        return http.build();
    }

    @Bean
    public Argon2PasswordEncoder passwordEncoder() {
        return Argon2PasswordEncoder.defaultsForSpringSecurity_v5_8();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder());
        daoAuthenticationProvider.setUserDetailsService(eLibUserService);
        return daoAuthenticationProvider;
    }
}

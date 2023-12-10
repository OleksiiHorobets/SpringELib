package com.fict.elibrary.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final UserDetailsService eLibUserService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authz -> {
                            authz
                                    .requestMatchers("/auth/**").permitAll()
                                    .requestMatchers("/error").permitAll()
                                    .requestMatchers("/pages/error/**").permitAll()
                                    .requestMatchers("/pages/**").permitAll()
                                    .requestMatchers("/static/**").permitAll()
                                    .anyRequest().authenticated();
                        }

//                                        .requestMatchers(new AntPathRequestMatcher("/login-action")).permitAll()
//                                        .anyRequest().authenticated()
//                                .permitAll()
//                                .requestMatchers("/swagger-ui/**", "/v3/api-docs/**").permitAll()
//                                .requestMatchers(POST, "/auth/**").permitAll()
//                                .requestMatchers(PUT, "/movies/**").hasRole("ADMIN")
//                                .requestMatchers(DELETE, "/movies/**").hasRole("ADMIN")
//                                .requestMatchers(POST, "/movies/**").hasRole("ADMIN")
//                                .anyRequest().authenticated()
                )
                .formLogin(
                        form -> form
                                .loginPage("/auth/login")
                                .loginProcessingUrl("/login")
                                .defaultSuccessUrl("/books") //fixme: check
//                                .failureHandler()
                                .failureUrl("/auth/login?invalidAuth=true")
                                .permitAll()
                ).authenticationProvider(authenticationProvider());

//                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
//                .authenticationProvider(authenticationProvider());
//                .addFilterBefore(jwtExceptionFilter, JwtAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public MvcRequestMatcher.Builder mvcMatcher(HandlerMappingIntrospector introspector) {
        return new MvcRequestMatcher.Builder(introspector).servletPath("/");
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

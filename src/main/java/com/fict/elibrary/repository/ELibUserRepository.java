package com.fict.elibrary.repository;

import com.fict.elibrary.entity.ELibUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ELibUserRepository extends JpaRepository<ELibUser, Long> {
    Optional<ELibUser> findByUsername(String username);
}

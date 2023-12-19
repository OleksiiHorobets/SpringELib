package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByTitle(String title);
}

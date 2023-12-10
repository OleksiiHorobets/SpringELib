package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RoleRepository extends JpaRepository<Role, Long> {
    @Query("SELECT role FROM Role role WHERE role.title = 'USER'")
    Role findUserRole(String title);
}

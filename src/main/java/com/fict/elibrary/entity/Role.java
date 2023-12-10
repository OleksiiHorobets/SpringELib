package com.fict.elibrary.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "roles", schema = "user_data")
public class Role implements GrantedAuthority {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "title", nullable = false, updatable = false, insertable = false)
    private String title;

    @OneToMany(mappedBy = "role",fetch = FetchType.LAZY)
    private List<ELibUser> eLibUserList = new ArrayList<>();

    @Override
    public String getAuthority() {
        return title;
    }
}

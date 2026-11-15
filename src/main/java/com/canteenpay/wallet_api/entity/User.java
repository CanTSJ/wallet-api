
package com.canteenpay.wallet_api.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "users")
public class User {

    @Id
    private UUID id;

    @Column(nullable = false, unique = true, length = 30)
    private String username;

    @Column(nullable = false, unique = true, length = 20)
    private String phone;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}

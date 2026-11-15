
package com.canteenpay.wallet_api.entity;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "accounts")
public class Account {

    @Id
    private UUID id;

    @Column(nullable = false)
    private long balance;

    @Column(name = "is_system_account", nullable = false)
    private boolean isSystemAccount;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    protected Account() {
    }

    public UUID getId() {
        return this.id;
    }

    public long getBalance() {
        return this.balance;
    }
}

package com.canteenpay.wallet_api.repository;

import com.canteenpay.wallet_api.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface AccountRepository
        extends JpaRepository<Account, UUID> {

}

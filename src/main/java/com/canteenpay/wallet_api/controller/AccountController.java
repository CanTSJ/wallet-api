package com.canteenpay.wallet_api.controller;
import org.springframework.web.bind.annotation.*;
import com.canteenpay.wallet_api.repository.AccountRepository;
import com.canteenpay.wallet_api.entity.Account;
import java.util.UUID;
import java.util.Optional;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class AccountController {

    private final AccountRepository accountRepository;

    public AccountController(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }
    public record AccountResponse(
            UUID id,
            long balance
    ){}

    @GetMapping("/accounts/{id}")
    public AccountResponse getAccount(@PathVariable UUID id) {

        Optional<Account> result =
                accountRepository.findById(id);

        if (result.isPresent()) {
            Account account = result.get();

            AccountResponse response = new AccountResponse(
                    account.getId(),
                    account.getBalance()
            );

            return response;
        } else {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Account Not Found: " + id
            );
        }
    }
}

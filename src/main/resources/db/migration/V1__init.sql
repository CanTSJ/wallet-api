CREATE TABLE users (
                       id UUID PRIMARY KEY,
                       username VARCHAR(30) NOT NULL UNIQUE,
                       phone VARCHAR(20) NOT NULL UNIQUE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transactions (
                              id UUID PRIMARY KEY,
                              description VARCHAR(50),
                              idempotency_key VARCHAR(100) UNIQUE,
                              type VARCHAR(20) NOT NULL CHECK (type IN ('TOPUP', 'PAYMENT')),
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounts (
                          id UUID PRIMARY KEY,
                          user_id UUID NOT NULL,
                          balance BIGINT NOT NULL,
                          is_system_account BOOLEAN NOT NULL DEFAULT FALSE,
                          CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id),
                          CONSTRAINT balance_logic_check CHECK (balance >= 0 OR is_system_account = true)
);

CREATE TABLE entries (
                         id UUID PRIMARY KEY,
                         transaction_id UUID NOT NULL,
                         account_id UUID NOT NULL,
                         amount BIGINT NOT NULL CHECK (amount > 0),
                         direction VARCHAR(6) NOT NULL CHECK (direction IN ('credit', 'debit')),
                         CONSTRAINT fk_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id),
                         CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES accounts(id)
);
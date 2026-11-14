CREATE TABLE users (
                       id UUID PRIMARY KEY,
                       name VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE accounts (
                          id UUID PRIMARY KEY,
                          user_id UUID REFERENCES users(id),
                          is_system_account BOOLEAN NOT NULL DEFAULT FALSE,
                          balance DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
                          created_at TIMESTAMP NOT NULL DEFAULT NOW(),
                          CONSTRAINT balance_logic_check CHECK (balance >= 0 OR is_system_account = true)
);

CREATE TABLE transactions (
                              id UUID PRIMARY KEY,
                              type VARCHAR(20) NOT NULL CHECK (type IN ('TOPUP', 'PAYMENT')),
                              idempotency_key VARCHAR(255) UNIQUE NOT NULL,
                              created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE entries (
                         id UUID PRIMARY KEY,
                         transaction_id UUID NOT NULL REFERENCES transactions(id),
                         account_id UUID NOT NULL REFERENCES accounts(id),
                         direction VARCHAR(10) NOT NULL CHECK (direction IN ('debit', 'credit')),
                         amount DECIMAL(15, 2) NOT NULL CHECK (amount > 0),
                         created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
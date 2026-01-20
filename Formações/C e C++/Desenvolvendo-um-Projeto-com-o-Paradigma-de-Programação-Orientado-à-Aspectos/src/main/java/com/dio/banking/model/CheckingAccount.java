package com.dio.banking.model;

/**
 * Representa uma Conta Corrente.
 */
public class CheckingAccount extends Account {

    public CheckingAccount(String accountNumber, double initialBalance) {
        super(accountNumber, initialBalance);
    }

    @Override
    public String getAccountType() {
        return "Conta Corrente";
    }
}

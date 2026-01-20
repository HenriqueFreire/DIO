package com.dio.banking.model;

/**
 * Representa uma Conta Poupança.
 */
public class SavingsAccount extends Account {

    public SavingsAccount(String accountNumber, double initialBalance) {
        super(accountNumber, initialBalance);
    }

    @Override
    public String getAccountType() {
        return "Conta Poupança";
    }
}

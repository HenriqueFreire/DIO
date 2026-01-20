package com.dio.banking.model;

/**
 * Representa uma Conta Salário.
 */
public class SalaryAccount extends Account {

    public SalaryAccount(String accountNumber, double initialBalance) {
        super(accountNumber, initialBalance);
    }

    @Override
    public String getAccountType() {
        return "Conta Salário";
    }
}

package com.dio.banking.model;

/**
 * Representa uma Conta de Investimento.
 */
public class InvestmentAccount extends Account {

    public InvestmentAccount(String accountNumber, double initialBalance) {
        super(accountNumber, initialBalance);
    }

    @Override
    public String getAccountType() {
        return "Conta Investimento";
    }
}

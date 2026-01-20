package com.dio.banking.model;

/**
 * Classe abstrata que representa uma conta bancária genérica.
 */
public abstract class Account {

    protected double balance;
    private String accountNumber;

    public Account(String accountNumber, double initialBalance) {
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
    }

    /**
     * Realiza um saque na conta. A lógica de verificação de saldo
     * será injetada por um aspecto.
     * @param amount Valor a ser sacado.
     */
    public void withdraw(double amount) {
        this.balance -= amount;
        System.out.println("Saque de R$" + amount + " realizado com sucesso na " + getAccountType() + " " + accountNumber + ". Novo saldo: R$" + this.balance);
    }

    public double getBalance() {
        return balance;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    /**
     * Retorna o tipo da conta.
     * @return String representando o tipo da conta.
     */
    public abstract String getAccountType();
}

package com.dio.banking.main;

import com.dio.banking.model.*;

public class Main {

    public static void main(String[] args) {
        System.out.println("Iniciando simulação bancária...");
        System.out.println("============================================\n");

        // Criando contas com saldos iniciais
        Account checking = new CheckingAccount("123-4", 1000.00);
        Account savings = new SavingsAccount("567-8", 500.00);
        Account salary = new SalaryAccount("910-1", 1500.00);
        Account investment = new InvestmentAccount("112-3", 2500.00);

        // --- Tentativa de saque com sucesso ---
        System.out.println("--- Tentativa de Saque Válido ---");
        System.out.printf("Saldo inicial da %s %s: R$%.2f%n", checking.getAccountType(), checking.getAccountNumber(), checking.getBalance());
        try {
            checking.withdraw(200.00);
        } catch (InsufficientBalanceException e) {
            System.err.println("Falha no saque: " + e.getMessage());
        }
        System.out.printf("Saldo final: R$%.2f%n", checking.getBalance());
        System.out.println("\n--------------------------------------------\n");


        // --- Tentativa de saque com saldo insuficiente ---
        System.out.println("--- Tentativa de Saque Inválido (Saldo Insuficiente) ---");
        System.out.printf("Saldo inicial da %s %s: R$%.2f%n", savings.getAccountType(), savings.getAccountNumber(), savings.getBalance());
        try {
            // Tenta sacar um valor maior que o saldo
            savings.withdraw(700.00);
        } catch (InsufficientBalanceException e) {
            // A mensagem de erro já é logada pelo aspecto, aqui apenas confirmamos a falha.
            System.out.println("Operação de saque falhou como esperado.");
        }
        System.out.printf("Saldo final: R$%.2f (não deve ter mudado)%n", savings.getBalance());
        System.out.println("\n--------------------------------------------\n");
        
        
        // --- Outra tentativa de saque com sucesso ---
        System.out.println("--- Tentativa de Saque Válido ---");
        System.out.printf("Saldo inicial da %s %s: R$%.2f%n", salary.getAccountType(), salary.getAccountNumber(), salary.getBalance());
        try {
            salary.withdraw(100.00);
        } catch (InsufficientBalanceException e) {
            System.err.println("Falha no saque: " + e.getMessage());
        }
        System.out.printf("Saldo final: R$%.2f%n", salary.getBalance());
        System.out.println("\n============================================");
        System.out.println("Fim da simulação.");
    }
}
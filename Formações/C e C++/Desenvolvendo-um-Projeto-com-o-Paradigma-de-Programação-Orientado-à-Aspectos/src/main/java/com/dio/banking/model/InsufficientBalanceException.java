package com.dio.banking.model;

/**
 * Exceção lançada quando o saldo é insuficiente para uma operação.
 */
public class InsufficientBalanceException extends RuntimeException {

    public InsufficientBalanceException(String message) {
        super(message);
    }
}

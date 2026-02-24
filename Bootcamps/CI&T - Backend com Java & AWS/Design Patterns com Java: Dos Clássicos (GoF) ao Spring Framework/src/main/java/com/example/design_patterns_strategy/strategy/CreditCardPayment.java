package com.example.design_patterns_strategy.strategy;

import org.springframework.stereotype.Component;

@Component
public class CreditCardPayment implements PaymentStrategy {
    private String name;
    private String cardNumber;
    private String cvv;
    private String dateOfExpiry;

    // Constructor for dependency injection (optional, but good practice for Spring)
    public CreditCardPayment() {}

    public CreditCardPayment(String name, String cardNumber, String cvv, String dateOfExpiry) {
        this.name = name;
        this.cardNumber = cardNumber;
        this.cvv = cvv;
        this.dateOfExpiry = dateOfExpiry;
    }

    @Override
    public void pay(double amount) {
        System.out.println(amount + " paid with credit card. Card Number: " + cardNumber);
        // In a real application, you would integrate with a payment gateway here.
    }
}

package com.example.design_patterns_strategy.strategy;

import org.springframework.stereotype.Component;

@Component
public class PayPalPayment implements PaymentStrategy {
    private String emailId;
    private String password;

    // Constructor for dependency injection (optional, but good practice for Spring)
    public PayPalPayment() {}

    public PayPalPayment(String emailId, String password) {
        this.emailId = emailId;
        this.password = password;
    }

    @Override
    public void pay(double amount) {
        System.out.println(amount + " paid using PayPal. Email: " + emailId);
        // In a real application, you would integrate with a PayPal API here.
    }
}

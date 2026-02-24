package com.example.design_patterns_strategy.controller;

import com.example.design_patterns_strategy.strategy.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService;

    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/process")
    public String processPayment(@RequestParam String strategy, @RequestParam double amount) {
        try {
            paymentService.processPayment(strategy, amount);
            return "Payment processed successfully using " + strategy + " strategy.";
        } catch (IllegalArgumentException e) {
            return "Error: " + e.getMessage();
        }
    }
}

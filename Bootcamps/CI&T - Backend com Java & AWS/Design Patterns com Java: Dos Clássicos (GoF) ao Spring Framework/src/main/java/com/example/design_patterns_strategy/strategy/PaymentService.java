package com.example.design_patterns_strategy.strategy;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

@Service
public class PaymentService {

    private final Map<String, PaymentStrategy> paymentStrategies = new HashMap<>();

    @Autowired
    public PaymentService(List<PaymentStrategy> strategies) {
        for (PaymentStrategy strategy : strategies) {
            // A more robust solution would involve a custom annotation or a factory
            // to map strategy names to instances. For simplicity, we'll use class names.
            String strategyName = strategy.getClass().getSimpleName().replace("Payment", "").toLowerCase();
            paymentStrategies.put(strategyName, strategy);
        }
    }

    public void processPayment(String strategyType, double amount) {
        PaymentStrategy strategy = paymentStrategies.get(strategyType.toLowerCase());
        if (strategy == null) {
            throw new IllegalArgumentException("Invalid payment strategy type: " + strategyType);
        }
        strategy.pay(amount);
    }
}

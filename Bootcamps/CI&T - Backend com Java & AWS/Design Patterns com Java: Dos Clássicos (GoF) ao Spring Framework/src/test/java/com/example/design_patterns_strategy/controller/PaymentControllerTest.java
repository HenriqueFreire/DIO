package com.example.design_patterns_strategy.controller;

import com.example.design_patterns_strategy.strategy.PaymentService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(PaymentController.class)
public class PaymentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private PaymentService paymentService;

    @Test
    void processCreditCardPaymentSuccessfully() throws Exception {
        double amount = 100.0;
        String strategy = "creditcard";
        doNothing().when(paymentService).processPayment(strategy, amount);

        mockMvc.perform(post("/payment/process")
                .param("strategy", strategy)
                .param("amount", String.valueOf(amount)))
                .andExpect(status().isOk())
                .andExpect(content().string("Payment processed successfully using creditcard strategy."));

        verify(paymentService, times(1)).processPayment(strategy, amount);
    }

    @Test
    void processPayPalPaymentSuccessfully() throws Exception {
        double amount = 50.0;
        String strategy = "paypal";
        doNothing().when(paymentService).processPayment(strategy, amount);

        mockMvc.perform(post("/payment/process")
                .param("strategy", strategy)
                .param("amount", String.valueOf(amount)))
                .andExpect(status().isOk())
                .andExpect(content().string("Payment processed successfully using paypal strategy."));

        verify(paymentService, times(1)).processPayment(strategy, amount);
    }

    @Test
    void processPaymentWithInvalidStrategy() throws Exception {
        double amount = 200.0;
        String strategy = "invalid";
        doThrow(new IllegalArgumentException("Invalid payment strategy type: invalid"))
                .when(paymentService).processPayment(strategy, amount);

        mockMvc.perform(post("/payment/process")
                .param("strategy", strategy)
                .param("amount", String.valueOf(amount)))
                .andExpect(status().isOk())
                .andExpect(content().string("Error: Invalid payment strategy type: invalid"));

        verify(paymentService, times(1)).processPayment(strategy, amount);
    }
}

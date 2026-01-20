package com.dio.banking.aspect;

import com.dio.banking.model.Account;
import com.dio.banking.model.InsufficientBalanceException;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import java.util.logging.Logger;

/**
 * Aspecto para verificar o saldo da conta antes de um saque.
 */
@Aspect
public class AccountBalanceAspect {

    private static final Logger logger = Logger.getLogger(AccountBalanceAspect.class.getName());

    /**
     * Define um pointcut que captura a execução do método withdraw em qualquer subclasse de Account.
     * Ele também captura os argumentos do método para que possam ser usados no advice.
     */
    @Pointcut("execution(* com.dio.banking.model.Account+.withdraw(double)) && args(amount) && target(account)")
    public void withdrawExecution(double amount, Account account) {}

    /**
     * Advice (conselho) que é executado ANTES do método capturado pelo pointcut 'withdrawExecution'.
     *
     * @param joinPoint O ponto de junção que expõe metadados sobre a chamada do método.
     * @param amount    O valor do saque, capturado pelo pointcut.
     * @param account   A instância da conta, capturada pelo pointcut.
     */
    @Before("withdrawExecution(amount, account)")
    public void checkBalance(JoinPoint joinPoint, double amount, Account account) {
        String logMessage = String.format(
                "LOG: Verificando saldo para saque de R$%.2f na %s %s...",
                amount,
                account.getAccountType(),
                account.getAccountNumber()
        );
        logger.info(logMessage);

        if (account.getBalance() < amount) {
            String errorMessage = String.format(
                    "LOG DE ERRO: Saldo insuficiente! Tentativa de sacar R$%.2f, mas o saldo é de R$%.2f.",
                    amount,
                    account.getBalance()
            );
            logger.severe(errorMessage);
            throw new InsufficientBalanceException(errorMessage);
        }

        logger.info("LOG: Saldo suficiente. Prosseguindo com o saque.");
    }
}

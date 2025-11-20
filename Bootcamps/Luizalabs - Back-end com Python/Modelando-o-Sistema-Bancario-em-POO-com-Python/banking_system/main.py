import textwrap
from banking_system.services.banking_controller import BankingController


def menu():
    menu_text = """\n
    ================ MENU ================
    [d]\tDepositar
    [s]\tSacar
    [e]\tExtrato
    [nc]\tNova conta
    [lc]\tListar contas
    [nu]\tNovo usuário
    [q]\tSair
    => """
    return input(textwrap.dedent(menu_text))


def main():
    controller = BankingController()

    while True:
        opcao = menu()

        if opcao == "d":
            controller.depositar()

        elif opcao == "s":
            controller.sacar()

        elif opcao == "e":
            controller.exibir_extrato()

        elif opcao == "nu":
            controller.criar_cliente()

        elif opcao == "nc":
            controller.criar_conta()

        elif opcao == "lc":
            controller.listar_contas()

        elif opcao == "q":
            break

        else:
            print("\n@@@ Operação inválida, por favor selecione novamente a operação desejada. @@@")


if __name__ == "__main__":
    main()

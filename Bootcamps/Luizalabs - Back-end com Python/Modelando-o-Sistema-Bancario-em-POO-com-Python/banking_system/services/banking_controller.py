import textwrap
from banking_system.models.customer import PessoaFisica
from banking_system.models.account import ContaCorrente
from banking_system.models.transaction import Deposito, Saque


class BankingController:
    def __init__(self):
        self._clientes = {}  # O(1) lookup by CPF
        self._contas = []

    def _filtrar_cliente(self, cpf):
        return self._clientes.get(cpf)

    def _recuperar_conta_cliente(self, cliente):
        if not cliente.contas:
            print("\n@@@ Cliente não possui conta! @@@")
            return None

        # FIXME: Não permite cliente escolher a conta
        return cliente.contas[0]

    def depositar(self):
        cpf = input("Informe o CPF do cliente: ")
        cliente = self._filtrar_cliente(cpf)

        if not cliente:
            print("\n@@@ Cliente não encontrado! @@@")
            return

        valor = float(input("Informe o valor do depósito: "))
        transacao = Deposito(valor)

        conta = self._recuperar_conta_cliente(cliente)
        if conta:
            cliente.realizar_transacao(conta, transacao)

    def sacar(self):
        cpf = input("Informe o CPF do cliente: ")
        cliente = self._filtrar_cliente(cpf)

        if not cliente:
            print("\n@@@ Cliente não encontrado! @@@")
            return

        valor = float(input("Informe o valor do saque: "))
        transacao = Saque(valor)

        conta = self._recuperar_conta_cliente(cliente)
        if conta:
            cliente.realizar_transacao(conta, transacao)

    def exibir_extrato(self):
        cpf = input("Informe o CPF do cliente: ")
        cliente = self._filtrar_cliente(cpf)

        if not cliente:
            print("\n@@@ Cliente não encontrado! @@@")
            return

        conta = self._recuperar_conta_cliente(cliente)
        if not conta:
            return

        print("\n================ EXTRATO ================")
        transacoes = conta.historico.transacoes
        extrato = ""
        if not transacoes:
            extrato = "Não foram realizadas movimentações."
        else:
            for transacao in transacoes:
                extrato += f"\n{transacao['tipo']}:\n\tR$ {transacao['valor']:.2f}"

        print(extrato)
        print(f"\nSaldo:\n\tR$ {conta.saldo:.2f}")
        print("==========================================")

    def criar_cliente(self):
        cpf = input("Informe o CPF (somente número): ")
        cliente = self._filtrar_cliente(cpf)

        if cliente:
            print("\n@@@ Já existe cliente com esse CPF! @@@")
            return

        nome = input("Informe o nome completo: ")
        data_nascimento = input("Informe a data de nascimento (dd-mm-aaaa): ")
        endereco = input("Informe o endereço (logradouro, nro - bairro - cidade/sigla estado): ")

        cliente = PessoaFisica(nome=nome, data_nascimento=data_nascimento, cpf=cpf, endereco=endereco)

        self._clientes[cpf] = cliente

        print("\n=== Cliente criado com sucesso! ===")

    def criar_conta(self):
        cpf = input("Informe o CPF do cliente: ")
        cliente = self._filtrar_cliente(cpf)

        if not cliente:
            print("\n@@@ Cliente não encontrado, fluxo de criação de conta encerrado! @@@")
            return

        numero_conta = len(self._contas) + 1
        conta = ContaCorrente.nova_conta(cliente=cliente, numero=numero_conta)
        self._contas.append(conta)
        cliente.adicionar_conta(conta)

        print("\n=== Conta criada com sucesso! ===")

    def listar_contas(self):
        for conta in self._contas:
            print("=" * 100)
            print(textwrap.dedent(str(conta)))
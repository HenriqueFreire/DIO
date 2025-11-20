import textwrap

def menu():
    menu_texto = """\n
    ================ MENU ================
    1 - Novo usuário
    2 - Nova conta
    3 - Depositar
    4 - Sacar
    5 - Extrato
    6 - Listar contas
    0 - Sair
    => """
    return input(textwrap.dedent(menu_texto))

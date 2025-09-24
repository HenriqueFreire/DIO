public class MaquinaDeBanho {
    private double nivelAgua;
    private double nivelShampoo;
    private boolean petNaMaquina;
    private boolean petLimpo;

    private final double CAPACIDADE_MAX_AGUA = 30.0;
    private final double CAPACIDADE_MAX_SHAMPOO = 10.0;
    private final double CONSUMO_BANHO_AGUA = 10.0;
    private final double CONSUMO_BANHO_SHAMPOO = 2.0;
    private final double CONSUMO_LIMPEZA_AGUA = 3.0;
    private final double CONSUMO_LIMPEZA_SHAMPOO = 1.0;
    private final double ABASTECIMENTO_PADRAO = 2.0;

    public MaquinaDeBanho() {
        this.nivelAgua = 0.0;
        this.nivelShampoo = 0.0;
        this.petNaMaquina = false;
        this.petLimpo = false;
    }

    public void colocarPetNaMaquina() {
        if (!petNaMaquina) {
            if (!petLimpo) {
                System.out.println("Máquina suja. Por favor, limpe a máquina antes de colocar um novo pet.");
                return;
            }
            petNaMaquina = true;
            petLimpo = false; // O pet recém-colocado ainda não está limpo
            System.out.println("Pet colocado na máquina.");
        } else {
            System.out.println("Já existe um pet na máquina.");
        }
    }

    public void retirarPetDaMaquina() {
        if (petNaMaquina) {
            petNaMaquina = false;
            if (!petLimpo) {
                System.out.println("Pet retirado da máquina sem estar limpo. A máquina precisa ser limpa.");
            } else {
                System.out.println("Pet limpo retirado da máquina.");
            }
        } else {
            System.out.println("Não há pet na máquina para retirar.");
        }
    }

    public void darBanhoNoPet() {
        if (!petNaMaquina) {
            System.out.println("Não há pet na máquina para dar banho.");
            return;
        }
        if (nivelAgua < CONSUMO_BANHO_AGUA) {
            System.out.println("Água insuficiente para o banho. Nível atual: " + nivelAgua + "L. Necessário: " + CONSUMO_BANHO_AGUA + "L.");
            return;
        }
        if (nivelShampoo < CONSUMO_BANHO_SHAMPOO) {
            System.out.println("Shampoo insuficiente para o banho. Nível atual: " + nivelShampoo + "L. Necessário: " + CONSUMO_BANHO_SHAMPOO + "L.");
            return;
        }

        nivelAgua -= CONSUMO_BANHO_AGUA;
        nivelShampoo -= CONSUMO_BANHO_SHAMPOO;
        petLimpo = true;
        System.out.println("Banho realizado com sucesso! Pet está limpo.");
    }

    public void abastecerAgua() {
        if (nivelAgua + ABASTECIMENTO_PADRAO <= CAPACIDADE_MAX_AGUA) {
            nivelAgua += ABASTECIMENTO_PADRAO;
            System.out.println("Água abastecida. Nível atual: " + nivelAgua + "L.");
        } else {
            nivelAgua = CAPACIDADE_MAX_AGUA;
            System.out.println("Capacidade máxima de água atingida. Nível atual: " + nivelAgua + "L.");
        }
    }

    public void abastecerShampoo() {
        if (nivelShampoo + ABASTECIMENTO_PADRAO <= CAPACIDADE_MAX_SHAMPOO) {
            nivelShampoo += ABASTECIMENTO_PADRAO;
            System.out.println("Shampoo abastecido. Nível atual: " + nivelShampoo + "L.");
        } else {
            nivelShampoo = CAPACIDADE_MAX_SHAMPOO;
            System.out.println("Capacidade máxima de shampoo atingida. Nível atual: " + nivelShampoo + "L.");
        }
    }

    public double verificarNivelAgua() {
        return nivelAgua;
    }

    public double verificarNivelShampoo() {
        return nivelShampoo;
    }

    public boolean verificarPetNaMaquina() {
        return petNaMaquina;
    }

    public void limparMaquina() {
        if (petNaMaquina) {
            System.out.println("Não é possível limpar a máquina com um pet dentro.");
            return;
        }
        if (petLimpo) {
            System.out.println("Máquina já está limpa.");
            return;
        }

        if (nivelAgua < CONSUMO_LIMPEZA_AGUA) {
            System.out.println("Água insuficiente para limpar a máquina. Nível atual: " + nivelAgua + "L. Necessário: " + CONSUMO_LIMPEZA_AGUA + "L.");
            return;
        }
        if (nivelShampoo < CONSUMO_LIMPEZA_SHAMPOO) {
            System.out.println("Shampoo insuficiente para limpar a máquina. Nível atual: " + nivelShampoo + "L. Necessário: " + CONSUMO_LIMPEZA_SHAMPOO + "L.");
            return;
        }

        nivelAgua -= CONSUMO_LIMPEZA_AGUA;
        nivelShampoo -= CONSUMO_LIMPEZA_SHAMPOO;
        petLimpo = true;
        System.out.println("Máquina limpa com sucesso!");
    }
}

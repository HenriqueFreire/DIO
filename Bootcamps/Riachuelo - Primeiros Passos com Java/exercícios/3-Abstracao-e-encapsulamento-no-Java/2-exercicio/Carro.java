public class Carro {
    private boolean ligado;
    private int velocidade;
    private int marcha;

    public Carro() {
        this.ligado = false;
        this.velocidade = 0;
        this.marcha = 0; // 0 para ponto morto
    }

    public void ligar() {
        if (!ligado) {
            ligado = true;
            System.out.println("Carro ligado.");
        } else {
            System.out.println("Carro já está ligado.");
        }
    }

    public void desligar() {
        if (ligado) {
            if (velocidade == 0 && marcha == 0) {
                ligado = false;
                System.out.println("Carro desligado.");
            } else {
                System.out.println("Para desligar, o carro deve estar em ponto morto (marcha 0) e com velocidade 0 km/h.");
            }
        } else {
            System.out.println("Carro já está desligado.");
        }
    }

    public void acelerar() {
        if (!ligado) {
            System.out.println("Carro está desligado. Não é possível acelerar.");
            return;
        }
        if (marcha == 0) {
            System.out.println("Carro em ponto morto. Não é possível acelerar.");
            return;
        }

        int novaVelocidade = velocidade + 1;
        if (novaVelocidade > 120) {
            System.out.println("Velocidade máxima atingida (120 km/h).");
            velocidade = 120;
            return;
        }

        if (verificarLimiteVelocidadeMarcha(marcha, novaVelocidade)) {
            velocidade = novaVelocidade;
            System.out.println("Acelerando. Velocidade atual: " + velocidade + " km/h.");
        } else {
            System.out.println("Não é possível acelerar mais nesta marcha. Troque para uma marcha superior.");
        }
    }

    public void diminuirVelocidade() {
        if (!ligado) {
            System.out.println("Carro está desligado. Não é possível diminuir a velocidade.");
            return;
        }

        int novaVelocidade = velocidade - 1;
        if (novaVelocidade < 0) {
            System.out.println("Velocidade mínima atingida (0 km/h).");
            velocidade = 0;
            return;
        }

        if (verificarLimiteVelocidadeMarcha(marcha, novaVelocidade)) {
            velocidade = novaVelocidade;
            System.out.println("Diminuindo velocidade. Velocidade atual: " + velocidade + " km/h.");
        } else {
            System.out.println("Não é possível diminuir mais a velocidade nesta marcha. Troque para uma marcha inferior.");
        }
    }

    public void virar(String direcao) {
        if (!ligado) {
            System.out.println("Carro está desligado. Não é possível virar.");
            return;
        }
        if (velocidade >= 1 && velocidade <= 40) {
            System.out.println("Virando para a " + direcao + ".");
        } else {
            System.out.println("Não é possível virar. A velocidade deve estar entre 1 km/h e 40 km/h.");
        }
    }

    public int verificarVelocidade() {
        return velocidade;
    }

    public void trocarMarcha(int novaMarcha) {
        if (!ligado) {
            System.out.println("Carro está desligado. Não é possível trocar a marcha.");
            return;
        }
        if (novaMarcha < 0 || novaMarcha > 6) {
            System.out.println("Marcha inválida. As marchas válidas são de 0 a 6.");
            return;
        }

        // Não permitir pular marcha
        if (Math.abs(novaMarcha - marcha) > 1 && novaMarcha != 0 && marcha != 0) {
            System.out.println("Não é permitido pular marchas. Troque para a marcha adjacente.");
            return;
        }

        // Verificar limites de velocidade para a nova marcha
        if (verificarLimiteVelocidadeMarcha(novaMarcha, velocidade)) {
            this.marcha = novaMarcha;
            System.out.println("Marcha trocada para: " + marcha + ".");
        } else {
            System.out.println("Não é possível trocar para a marcha " + novaMarcha + " na velocidade atual. Ajuste a velocidade.");
        }
    }

    private boolean verificarLimiteVelocidadeMarcha(int m, int v) {
        switch (m) {
            case 0: // Ponto morto
                return v == 0;
            case 1:
                return v >= 0 && v <= 20;
            case 2:
                return v >= 21 && v <= 40;
            case 3:
                return v >= 41 && v <= 60;
            case 4:
                return v >= 61 && v <= 80;
            case 5:
                return v >= 81 && v <= 100;
            case 6:
                return v >= 101 && v <= 120;
            default:
                return false;
        }
    }

    public boolean estaLigado() {
        return ligado;
    }

    public int getMarcha() {
        return marcha;
    }
}

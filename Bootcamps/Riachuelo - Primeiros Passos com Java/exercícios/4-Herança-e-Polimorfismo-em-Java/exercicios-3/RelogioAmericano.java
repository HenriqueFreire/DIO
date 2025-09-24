public class RelogioAmericano extends Relogio {

    public RelogioAmericano(int hora, int minuto, int segundo) {
        super(hora, minuto, segundo);
        // A validação de hora (0-23) já é feita na superclasse. 
        // A representação AM/PM será feita no getHoraFormatada.
    }

    @Override
    public void setHora(int hora) {
        // Para o relógio americano, a hora deve ser de 0 a 23 internamente para consistência
        // e a conversão para AM/PM é feita apenas na exibição.
        if (hora >= 0 && hora <= 23) {
            super.setHora(hora);
        } else {
            throw new IllegalArgumentException("Hora inválida para Relógio Americano. Deve estar entre 0 e 23.");
        }
    }

    @Override
    public String getHoraFormatada() {
        int hora = getHora();
        String ampm = "AM";
        if (hora == 0) {
            hora = 12; // 00:xx:xx é 12 AM
        } else if (hora == 12) {
            ampm = "PM"; // 12:xx:xx é 12 PM
        } else if (hora > 12) {
            hora -= 12;
            ampm = "PM";
        }
        return String.format("%02d:%02d:%02d %s", hora, getMinuto(), getSegundo(), ampm);
    }

    @Override
    public void sincronizar(Relogio outroRelogio) {
        this.setHora(outroRelogio.getHora());
        this.setMinuto(outroRelogio.getMinuto());
        this.setSegundo(outroRelogio.getSegundo());
        System.out.println("Relógio Americano sincronizado para: " + this.getHoraFormatada());
    }
}

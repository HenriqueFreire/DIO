public class MainRelogios {
    public static void main(String[] args) {
        // Testando Relogio Brasileiro
        RelogioBrasileiro relogioBR1 = new RelogioBrasileiro(14, 30, 45);
        System.out.println("Relógio BR 1: " + relogioBR1.getHoraFormatada());

        RelogioBrasileiro relogioBR2 = new RelogioBrasileiro(23, 59, 59);
        System.out.println("Relógio BR 2: " + relogioBR2.getHoraFormatada());

        // Testando Relogio Americano
        RelogioAmericano relogioUS1 = new RelogioAmericano(14, 30, 45);
        System.out.println("Relógio US 1: " + relogioUS1.getHoraFormatada());

        RelogioAmericano relogioUS2 = new RelogioAmericano(0, 5, 10); // 12:05:10 AM
        System.out.println("Relógio US 2: " + relogioUS2.getHoraFormatada());

        RelogioAmericano relogioUS3 = new RelogioAmericano(12, 0, 0); // 12:00:00 PM
        System.out.println("Relógio US 3: " + relogioUS3.getHoraFormatada());

        RelogioAmericano relogioUS4 = new RelogioAmericano(23, 59, 59); // 11:59:59 PM
        System.out.println("Relógio US 4: " + relogioUS4.getHoraFormatada());

        System.out.println("\n--- Testando Sincronização ---");
        // Sincronizando relógio BR com relógio US
        relogioBR1.sincronizar(relogioUS2); // BR1 (14:30:45) -> BR1 (00:05:10)
        System.out.println("Relógio BR 1 após sincronizar com US2: " + relogioBR1.getHoraFormatada());

        // Sincronizando relógio US com relógio BR
        relogioUS1.sincronizar(relogioBR2); // US1 (02:30:45 PM) -> US1 (11:59:59 PM)
        System.out.println("Relógio US 1 após sincronizar com BR2: " + relogioUS1.getHoraFormatada());

        System.out.println("\n--- Testando Polimorfismo ---");
        Relogio[] relogios = new Relogio[4];
        relogios[0] = new RelogioBrasileiro(9, 15, 0);
        relogios[1] = new RelogioAmericano(9, 15, 0);
        relogios[2] = new RelogioBrasileiro(20, 40, 30);
        relogios[3] = new RelogioAmericano(20, 40, 30);

        for (Relogio r : relogios) {
            System.out.println("Tipo: " + r.getClass().getSimpleName() + ", Hora: " + r.getHoraFormatada());
        }

        System.out.println("\n--- Sincronizando array de relógios com um novo tempo (10:20:30) ---");
        Relogio novoTempo = new RelogioBrasileiro(10, 20, 30); // Pode ser qualquer implementação de Relogio

        for (Relogio r : relogios) {
            r.sincronizar(novoTempo);
            System.out.println("Tipo: " + r.getClass().getSimpleName() + ", Nova Hora: " + r.getHoraFormatada());
        }
    }
}
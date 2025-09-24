public abstract class Usuario {
    private String nome;
    private String email;
    private String senha;
    private boolean administrador;

    public Usuario(String nome, String email, String senha, boolean administrador) {
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.administrador = administrador;
    }

    // Getters
    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public boolean isAdministrador() {
        return administrador;
    }

    // Setters (para atributos que fazem sentido ter)
    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSenha(String senha) {
        // Em um sistema real, a senha seria hashada e não armazenada em texto puro.
        this.senha = senha;
    }

    // Métodos comuns
    public boolean realizarLogin(String email, String senha) {
        if (this.email.equals(email) && this.senha.equals(senha)) {
            System.out.println(nome + " logado com sucesso.");
            return true;
        }
        System.out.println("Falha no login para " + nome + ".");
        return false;
    }

    public void realizarLogoff() {
        System.out.println(nome + " deslogado.");
    }

    public void alterarDados(String novoNome, String novoEmail) {
        this.nome = novoNome;
        this.email = novoEmail;
        System.out.println("Dados de " + nome + " alterados para Nome: " + novoNome + ", Email: " + novoEmail);
    }

    public void alterarSenha(String novaSenha) {
        setSenha(novaSenha); // Reutiliza o setter que pode ter lógica de hash
        System.out.println("Senha de " + nome + " alterada com sucesso.");
    }
}

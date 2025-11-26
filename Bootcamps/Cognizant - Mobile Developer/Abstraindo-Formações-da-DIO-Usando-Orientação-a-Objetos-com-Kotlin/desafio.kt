enum class Nivel { BASICO, INTERMEDIARIO, DIFICIL }

data class Aluno(val nome: String)

data class ConteudoEducacional(val nome: String, val duracao: Int = 60)

data class Formacao(val nome: String, val nivel: Nivel, val conteudos: List<ConteudoEducacional>) {

    private val inscritos = mutableListOf<Aluno>()
    
    fun matricular(vararg alunos: Aluno) {
        inscritos.addAll(alunos)
        println("Matrícula realizada com sucesso para os alunos: ${alunos.joinToString { it.nome }} na formação '$nome'.")
    }

    fun exibirDetalhes() {
        println("Formação: $nome")
        println("Nível: $nivel")
        println("Conteúdos:")
        conteudos.forEach { println("- ${it.nome} (${it.duracao} min)") }
        println("Alunos Inscritos:")
        inscritos.forEach { println("- ${it.nome}") }
    }
}

fun main() {
    // 1. Criar conteúdos educacionais
    val kotlinBasico = ConteudoEducacional("Introdução ao Kotlin", 90)
    val oopAvancado = ConteudoEducacional("Princípios de Orientação a Objetos com Kotlin", 120)
    val androidEssencial = ConteudoEducacional("Desenvolvimento de Apps Android", 180)

    // 2. Criar uma lista de conteúdos para uma formação
    val conteudosFormacaoKotlin = listOf(kotlinBasico, oopAvancado)

    // 3. Criar uma formação
    val formacaoKotlin = Formacao("Desenvolvedor Kotlin", Nivel.INTERMEDIARIO, conteudosFormacaoKotlin)

    // 4. Criar alguns alunos
    val aluno1 = Aluno("Maria")
    val aluno2 = Aluno("João")
    val aluno3 = Aluno("Ana")

    // 5. Matricular os alunos na formação
    formacaoKotlin.matricular(aluno1, aluno2)

    // 6. Matricular outro aluno
    formacaoKotlin.matricular(aluno3)

    // 7. Exibir detalhes da formação e seus inscritos
    println("\n-- Detalhes da Formação --")
    formacaoKotlin.exibirDetalhes()

    // Cenário 2: Outra formação
    val formacaoAndroid = Formacao("Desenvolvedor Android Expert", Nivel.DIFICIL, listOf(androidEssencial, oopAvancado))
    val aluno4 = Aluno("Carlos")
    formacaoAndroid.matricular(aluno4)

    println("\n-- Detalhes da Formação --")
    formacaoAndroid.exibirDetalhes()
}
# Aprenda Kotlin Com Exemplos: Desafio de Projeto (Lab)

Este repositório contém a solução para o Desafio de Projeto "Abstraindo Formações da DIO Usando Orientação a Objetos com Kotlin".

## O Desafio

O objetivo era modelar o domínio de uma plataforma de ensino, a DIO, que consiste em `Formacoes` contendo `ConteudosEducacionais` e `Alunos` matriculados.

**Domínio:**
> A [DIO](https://web.dio.me) possui `Formacoes` incríveis que têm como objetivo oferecer um conjunto de `ConteudosEducacionais` voltados para uma stack tecnológica específica, preparando profissionais de TI para o mercado de trabalho. `Formacoes` possuem algumas características importantes, como `nome`, `nivel` e seus respectivos `conteudosEducacionais`. Além disso, tais experiências educacionais têm um comportamento relevante ao nosso domínio, definido pela capacidade de `matricular` um ou mais `Alunos`.

## Solução Implementada

A solução foi implementada no arquivo `desafio.kt` e consiste nas seguintes classes, seguindo as melhores práticas de Orientação a Objetos e Kotlin:

- `enum class Nivel`: Representa os níveis de dificuldade de uma formação (`BASICO`, `INTERMEDIARIO`, `DIFICIL`).
- `data class Aluno(val nome: String)`: Representa um aluno.
- `data class ConteudoEducacional(val nome: String, val duracao: Int)`: Representa uma unidade de conteúdo educacional.
- `data class Formacao(...)`: A classe central que agrupa os conteúdos, define o nível, gerencia as matrículas dos alunos e exibe os detalhes da formação.

## Como Executar

Para garantir um ambiente de desenvolvimento consistente e reprodutível, este projeto utiliza o [Nix](https://nixos.org/).

1.  **Instale o Nix** (caso ainda não o tenha, siga o [guia oficial](https://nixos.org/download.html)).
2.  No diretório do projeto, execute o comando:
    ```bash
    nix-shell
    ```
    Este comando irá baixar as dependências (`Kotlin` e `JDK`) definidas no arquivo `shell.nix` e iniciará um shell com tudo o que é necessário para rodar o projeto.

3.  Dentro do `nix-shell`, compile e execute a solução com os seguintes comandos:
    ```bash
    # 1. Compilar o código-fonte em um arquivo JAR executável
    kotlinc desafio.kt -include-runtime -d desafio.jar

    # 2. Executar o programa
    java -jar desafio.jar
    ```

## Código Final (`desafio.kt`)

```kotlin
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
```
```
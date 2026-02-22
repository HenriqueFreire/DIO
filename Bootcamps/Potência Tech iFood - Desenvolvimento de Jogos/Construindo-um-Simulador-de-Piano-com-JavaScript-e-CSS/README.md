# Simulador de Piano Virtual

Este é um simulador de piano virtual responsivo que permite aos usuários tocar notas de piano usando cliques do mouse ou entrada de teclado. Ele inclui recursos para controle de volume e alternância da exibição das legendas das teclas.

## Tecnologias Utilizadas

*   **HTML5**: Para estruturar a interface do piano.
*   **CSS3**: Para estilizar o piano, incluindo teclas brancas e pretas distintas, estados ativos e layout geral.
*   **JavaScript**: Para lidar com interações do usuário (cliques, pressionamentos de teclado), tocar áudio, gerenciar o volume e alternar as legendas das teclas.

## Funcionalidades

*   **Teclas de Piano Interativas**: Clique nas teclas brancas e pretas do piano para tocar as notas correspondentes.
*   **Suporte de Teclado**: Use o teclado do seu computador para tocar notas, com teclas específicas mapeadas para as notas do piano.
*   **Controle de Volume**: Ajuste o volume principal do piano usando um controle deslizante dedicado.
*   **Alternar Legendas das Teclas**: Mostre ou oculte as legendas das teclas do teclado nas teclas do piano para uma interface mais limpa ou para praticar o reconhecimento de notas.
*   **Feedback Visual**: As teclas acendem quando pressionadas (seja pelo mouse ou teclado) para fornecer feedback visual.

## Mapeamento de Teclas

As seguintes teclas do teclado são mapeadas para as notas do piano:

| Tecla do Teclado | Nota do Piano |
| :--------------- | :------------ |
| `a`              | Tecla Branca  |
| `w`              | Tecla Preta   |
| `s`              | Tecla Branca  |
| `e`              | Tecla Preta   |
| `d`              | Tecla Branca  |
| `f`              | Tecla Preta   |
| `t`              | Tecla Branca  |
| `g`              | Tecla Preta   |
| `y`              | Tecla Branca  |
| `h`              | Tecla Preta   |
| `u`              | Tecla Branca  |
| `j`              | Tecla Preta   |
| `k`              | Tecla Branca  |
| `o`              | Tecla Preta   |
| `l`              | Tecla Branca  |
| `p`              | Tecla Preta   |
| `;`              | Tecla Branca  |

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
.
├── index.html
├── README.md
└── src/
    ├── tunes/        # Contém arquivos de áudio para as notas do piano
    ├── scripts/
    │   └── engine.js # Lógica JavaScript principal
    └── styles/
        ├── main.css  # CSS principal para estilização do piano
        └── reset.css # Reset CSS para estilização consistente
```

## Configuração

Para que o simulador de piano funcione completamente e produza som, você precisa fornecer arquivos de áudio para cada nota.

1.  **Crie uma pasta `tunes`**: Certifique-se de que há uma pasta chamada `tunes` dentro do diretório `src` (ou seja, `src/tunes/`).
2.  **Adicione arquivos de áudio**: Coloque arquivos de áudio `.wav` para cada nota dentro da pasta `src/tunes/`. Os nomes dos arquivos esperados correspondem aos atributos `data-key` encontrados em `index.html`:
    *   `a.wav`
    *   `w.wav`
    *   `s.wav`
    *   `e.wav`
    *   `d.wav`
    *   `f.wav`
    *   `t.wav`
    *   `g.wav`
    *   `y.wav`
    *   `h.wav`
    *   `u.wav`
    *   `j.wav`
    *   `k.wav`
    *   `o.wav`
    *   `l.wav`
    *   `p.wav`
    *   `;.wav`

    *(Você pode encontrar amostras de som de piano gratuitas online ou gravar as suas próprias.)*

## Como Executar

1.  **Abra `index.html`**: Abra o arquivo `index.html` no seu navegador da web (por exemplo, clicando duas vezes nele).
2.  **Interaja**:
    *   Use o mouse para clicar nas teclas do piano.
    *   Use as teclas do teclado especificadas (veja "Mapeamento de Teclas" acima) para tocar as notas.
    *   Ajuste o volume usando o controle deslizante no cabeçalho.
    *   Alterne a exibição das legendas das teclas usando a caixa de seleção "Teclas".

Divirta-se tocando seu piano virtual!

// Seleciona todos os buracos do jogo
const holes = document.querySelectorAll('.hole');
// Seleciona o elemento que exibe a pontuação
const scoreDisplay = document.getElementById('score');
// Seleciona o elemento que exibe o tempo restante
const timeLeftDisplay = document.getElementById('time-left');
// Seleciona os elementos de áudio para os efeitos sonoros
let whackSound; // Som ao acertar o Ralph
let gameoverSound; // Som de fim de jogo

// Elementos dos painéis de controle
const startPanel = document.getElementById('start-panel'); // Painel de início
const gameOverPanel = document.getElementById('game-over-panel'); // Painel de fim de jogo
const panelStartButton = document.getElementById('panel-start-button'); // Botão de iniciar no painel de início
const replayButton = document.getElementById('replay-button'); // Botão de jogar novamente no painel de fim de jogo
const finalScoreDisplay = document.getElementById('final-score'); // Exibe a pontuação final

// Elementos do jogo que precisam ser escondidos/mostrados
const gameElements = document.querySelector('.game-container').children; // Todos os filhos diretos do container do jogo
const h1Element = document.querySelector('h1'); // O elemento H1 principal do jogo

// Variáveis de estado do jogo
let score = 0; // Pontuação atual
let timeLeft = 60; // Tempo restante em segundos
let lastHole; // Armazena o último buraco onde o Ralph apareceu para evitar repetição imediata
let timerId; // ID do temporizador principal do jogo (countdown)
let moleTimerId; // ID do temporizador para o Ralph aparecer/desaparecer

// Função para gerar um tempo aleatório entre min e max
function randomTime(min, max) {
  return Math.round(Math.random() * (max - min) + min);
}

// Função para selecionar um buraco aleatório para o Ralph aparecer
function randomHole(holes) {
  const idx = Math.floor(Math.random() * holes.length); // Gera um índice aleatório
  const hole = holes[idx]; // Seleciona o buraco correspondente
  // Evita que o Ralph apareça no mesmo buraco duas vezes seguidas
  if (hole === lastHole) {
    return randomHole(holes);
  }
  lastHole = hole; // Atualiza o último buraco
  return hole;
}

// Função principal para fazer o Ralph 'aparecer' e 'desaparecer'
function peep() {
  const time = randomTime(1000, 2000); // Tempo que o Ralph ficará visível
  const hole = randomHole(holes); // Seleciona um buraco aleatório
  hole.classList.add('up'); // Adiciona a classe 'up' para mover o Ralph para cima (visível)

  const mole = document.createElement('div'); // Cria um novo elemento div para o Ralph
  mole.classList.add('mole'); // Adiciona a classe 'mole' para os estilos base
  mole.classList.add('ralph-mole'); // Adiciona a classe 'ralph-mole' para os estilos de sprite e animação
  hole.appendChild(mole); // Adiciona o Ralph ao buraco

  // Define um temporizador para o Ralph desaparecer
  moleTimerId = setTimeout(() => {
    hole.classList.remove('up'); // Remove a classe 'up' para mover o Ralph para baixo (invisível)
    if (hole.contains(mole)) { // Verifica se o Ralph ainda existe antes de remover
      hole.removeChild(mole); // Remove o elemento Ralph do buraco
    }
    // Se ainda há tempo de jogo, faz outro Ralph aparecer
    if (timeLeft > 0) {
      peep();
    }
  }, time);
}

// Inicia o jogo
function startGame() {
  // Esconde os painéis e mostra os elementos do jogo
  startPanel.classList.add('hidden');
  gameOverPanel.classList.add('hidden');
  for (let i = 0; i < gameElements.length; i++) {
    if (gameElements[i] !== startPanel && gameElements[i] !== gameOverPanel) {
      gameElements[i].classList.remove('hidden');
    }
  }
  h1Element.classList.remove('hidden'); // Garante que o H1 principal esteja visível

  score = 0; // Reinicia a pontuação
  timeLeft = 60; // Reinicia o tempo
  scoreDisplay.textContent = score; // Atualiza o placar
  timeLeftDisplay.textContent = timeLeft; // Atualiza o tempo

  // Limpa quaisquer temporizadores existentes para evitar múltiplos jogos simultâneos
  clearInterval(timerId);
  clearTimeout(moleTimerId);

  peep(); // Faz o primeiro Ralph aparecer
  // Inicia o temporizador principal do jogo
  timerId = setInterval(() => {
    timeLeft--; // Decrementa o tempo
    timeLeftDisplay.textContent = timeLeft; // Atualiza a exibição do tempo
    // Se o tempo acabar, finaliza o jogo
    if (timeLeft === 0) {
      clearInterval(timerId); // Para o temporizador principal
      clearTimeout(moleTimerId); // Para o temporizador do Ralph
      gameoverSound.play(); // Toca o som de fim de jogo
      endGame(); // Chama a função para finalizar o jogo
    }
  }, 1000); // A cada 1 segundo
}

// Finaliza o jogo
function endGame() {
  console.log('endGame() called'); // Log 1

  // Esconde os elementos do jogo e mostra o painel de fim de jogo
  for (let i = 0; i < gameElements.length; i++) {
    gameElements[i].classList.add('hidden');
  }
  h1Element.classList.add('hidden'); // Esconde o H1 principal

  console.log('Before showing gameOverPanel. is hidden:', gameOverPanel.classList.contains('hidden')); // Log 2
  gameOverPanel.classList.remove('hidden'); // Mostra o painel de fim de jogo
  console.log('After showing gameOverPanel. is hidden:', gameOverPanel.classList.contains('hidden')); // Log 3

  finalScoreDisplay.textContent = score; // Exibe a pontuação final

  // Remove quaisquer Ralphs restantes dos buracos
  holes.forEach(hole => {
    hole.classList.remove('up'); // Garante que o Ralph esteja 'para baixo'
    while (hole.firstChild) {
      hole.removeChild(hole.firstChild); // Remove o elemento Ralph do buraco
    }
  });
  console.log('endGame() finished'); // Log 4
}

// Função chamada quando o Ralph é acertado
function whack(e) {
  if (!e.isTrusted) return; // Proteção contra trapaças (cliques sintéticos)
  score++; // Incrementa a pontuação
  this.parentNode.classList.remove('up'); // Move o Ralph para baixo (some)
  scoreDisplay.textContent = score; // Atualiza a exibição da pontuação
  whackSound.currentTime = 0; // Reinicia o som de acerto
  whackSound.play(); // Toca o som de acerto
  this.remove(); // Remove o Ralph acertado
  clearTimeout(moleTimerId); // Limpa o temporizador do Ralph acertado para evitar que ele reapareça sozinho
  // Se o jogo ainda estiver rolando, faz outro Ralph aparecer
  if (timeLeft > 0) {
    peep();
  }
}

// Configuração inicial ao carregar a janela: esconde elementos do jogo, mostra o painel de início
window.onload = () => {
  // Atribui os elementos de áudio depois que o DOM está carregado
  whackSound = document.getElementById('whack-sound');
  gameoverSound = document.getElementById('gameover-sound');

  for (let i = 0; i < gameElements.length; i++) {
    if (gameElements[i] !== startPanel && gameElements[i] !== gameOverPanel) {
      gameElements[i].classList.add('hidden');
    }
  }
  h1Element.classList.add('hidden'); // Esconde o H1 principal
  startPanel.classList.remove('hidden'); // Mostra o painel de início
}

// Adiciona event listeners a cada buraco para detectar cliques
holes.forEach(hole => {
  hole.addEventListener('click', (e) => {
    // Verifica se o clique foi diretamente no elemento 'mole' (Ralph)
    if (e.target.classList.contains('mole')) {
      whack.call(e.target, e); // Chama a função whack no contexto do Ralph clicado
    }
  });
});

// Adiciona event listeners aos botões dos painéis para iniciar o jogo
panelStartButton.addEventListener('click', startGame);
replayButton.addEventListener('click', startGame);
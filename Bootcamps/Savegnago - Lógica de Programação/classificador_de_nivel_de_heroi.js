const readline = require('readline');

function criarMensagem(nome, categoria = 'Ferro') {
  console.log(`O Herói de nome ${nome} está no nível ${categoria}`);
}

  function classificarHeroi(nome, experiencia, callback) {
  const ranking = [
    { nivel: 1000, categoria: 'Ferro' },
    { nivel: 2000, categoria: 'Bronze' },
    { nivel: 5000, categoria: 'Prata' },
    { nivel: 7000, categoria: 'Ouro' },
    { nivel: 8000, categoria: 'Platina' },
    { nivel: 9000, categoria: 'Ascendente' },
    { nivel: 10000, categoria: 'Imortal' },
    { nivel: Infinity, categoria: 'Radiante' }
  ];

  ranking.forEach(item => {
    if (experiencia <= item.nivel) {
      callback(nome, item.categoria);
      return;
    }
  });
}

function dadosDoHeroi(callback) {
  const cliPrompt = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  cliPrompt.question('Digite o nome do herói: ', nome => {
    cliPrompt.question('Digite a experiência do herói: ', experiencia => {
      cliPrompt.close();
      callback(nome, parseInt(experiencia), criarMensagem);
    });
  });
}

dadosDoHeroi(classificarHeroi);
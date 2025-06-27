const readline = require('readline');

function criarMensagem(saldoVitorias, nivel) {
  console.log(`O Herói tem de saldo de ${saldoVitorias}% vitórias e está no nível ${nivel}`);
}

  function classificarHeroi(quantVitorias, quantDerrotas, callback) {
    const saldoVitorias = (quantVitorias / (quantVitorias + quantDerrotas)) * 100;
  const ranking = [
    { quantVitorias: 20, nivel: 'Ferro' },
    { quantVitorias: 40, nivel: 'Bronze' },
    { quantVitorias: 60, nivel: 'Prata' },
    { quantVitorias: 80, nivel: 'Ouro' },
    { quantVitorias: 95, nivel: 'Diamante' },
  ];

  for (let i = 0; i < ranking.length; i++) {
    const item = ranking[i];
    if (saldoVitorias <= item.quantVitorias) {
      callback(saldoVitorias, item.nivel);
      break;
    }
  }
}

function dadosDoHeroi(callback) {
  const cliPrompt = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  cliPrompt.question('Digite o número de vitórias: ', quantVitorias => {
    cliPrompt.question('Digite o número de derrotas: ', quantDerrotas => {
      cliPrompt.close();
      callback(parseInt(quantVitorias), parseInt(quantDerrotas), criarMensagem);
    });
  });
}

dadosDoHeroi(classificarHeroi);
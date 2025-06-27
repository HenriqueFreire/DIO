class Heroi {
  constructor(nome, idade, tipo) {
    this.nome = nome;
    this.idade = idade;
    this.tipo = tipo;
  }

  atacar() {
    let ataque;
    switch (this.tipo) {
      case 'mago':
        ataque = 'usou magia';
        break;
      case 'guerreiro':
        ataque = 'usou espada';
        break;
      case 'monge':
        ataque = 'usou artes marciais';
        break;
      case 'ninja':
        ataque = 'usou shuriken';
        break;
      default:
        ataque = 'realizou um ataque desconhecido';
    }
    console.log(`O ${this.tipo} atacou usando ${ataque}`);
  }
}

const mago = new Heroi('Gandalf', 600, 'mago');
mago.atacar();

const guerreiro = new Heroi('Conan', 30, 'guerreiro');
guerreiro.atacar();

const ninja = new Heroi('Naruto Uzumaki', 32, 'ninja');
ninja.atacar();

const monge = new Heroi('Shaolin', 25, 'monge');
monge.atacar();

const cavaleiroJedi = new Heroi('Yoda', 950, 'Jedi');
cavaleiroJedi.atacar();


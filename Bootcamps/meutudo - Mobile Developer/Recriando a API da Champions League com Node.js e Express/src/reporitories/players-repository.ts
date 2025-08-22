import { PlayerModel } from '../models/player-model';

const dataBase: PlayerModel[] = [
  { id: 1, name: 'Raphinha', position: 'Midfielder', team: 'Barcelona' },
  { id: 2, name: 'Vinicius Jr.', position: 'Forward', team: 'Real Madrid' },
  { id: 3, name: 'Rice', position: 'Defender', team: 'Arsenal' },
  { id: 4, name: 'Haaland', position: 'Forward', team: 'Manchester City' }
];

export const findAllPlayers = async (): Promise<PlayerModel[]> => {
  return dataBase;
}

export const findPlayerById = async (id: number): Promise<PlayerModel | null> => {
  const player = dataBase.find(player => player.id === id);
  return player || null;
}

export const insertPlayer = async (player: PlayerModel) => {
  dataBase.push(player);
}
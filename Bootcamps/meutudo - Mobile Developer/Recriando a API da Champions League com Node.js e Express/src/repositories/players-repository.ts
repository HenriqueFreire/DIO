import { PlayerModel } from "../models/players-model";
import { ClubsModel } from "../models/clubs-model";
import { StatisticsModel } from "../models/statisitcs-model";
import fs from "fs/promises";

export const findAllPlayers = async (): Promise<PlayerModel[]> => {
    const database = await fs.readFile("./src/data/players.json", "utf-8");
    const players: PlayerModel[] = JSON.parse(database);
    return players;
};

export const findPlayerById = async (id: number): Promise<PlayerModel | null> => {
    const database = await fs.readFile("./src/data/players.json", "utf-8");
    const players: PlayerModel[] = JSON.parse(database);
    const player = players.find(player => player.id === id);
    return player || null;
};

export const insertPlayer = async (player: PlayerModel): Promise<PlayerModel> => {
    const database = await fs.readFile("./src/data/players.json", "utf-8");
    const players: PlayerModel[] = JSON.parse(database);
    players.push(player);
    await fs.writeFile("./src/data/players.json", JSON.stringify(players));
    return player;
};

export const deleteOnePlayer = async (id: number) => {
    const database = await fs.readFile("./src/data/players.json", "utf-8");
    const players: PlayerModel[] = JSON.parse(database);
    const index = players.findIndex(player => player.id === id);
    if (index !== -1){
        players.splice(index, 1);
        await fs.writeFile("./src/data/players.json", JSON.stringify(players));
        return true;
    } else {
        return false;
    }
};

export const updataPlayerById = async (id: number, statistic: StatisticsModel): Promise<PlayerModel> => {
    const database = await fs.readFile("./src/data/players.json", "utf-8");
    const players: PlayerModel[] = JSON.parse(database);
    const index = players.findIndex(player => player.id === id);
    if (index !== -1){
        players[index].statistics = statistic;
        await fs.writeFile("./src/data/players.json", JSON.stringify(players));
    }
    return players[index];
};
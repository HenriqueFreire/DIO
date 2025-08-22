import { ClubsModel } from "../models/clubs-model";
import fs from "fs/promises";

export const findAllClubs = async (): Promise<ClubsModel[]> => {
    const database = await fs.readFile("./src/data/clubs.json", "utf-8");
    const clubs: ClubsModel[] = JSON.parse(database);
    return clubs;
};

export const findPlayerById = async (id: number): Promise<ClubsModel | null> => {
    const database = await fs.readFile("./src/data/clubs.json", "utf-8");
    const data: ClubsModel[] = JSON.parse(database);
    const clubs = data.find(clubs => clubs.id === id);
    return clubs || null;
};

export const insertPlayer = async (clubs: ClubsModel): Promise<ClubsModel> => {
    const database = await fs.readFile("./src/data/clubs.json", "utf-8");
    const data: ClubsModel[] = JSON.parse(database);
    data.push(clubs);
    await fs.writeFile("./src/data/clubs.json", JSON.stringify(data));
    return clubs;
};

export const deleteOnePlayer = async (id: number) => {
    const database = await fs.readFile("./src/data/clubs.json", "utf-8");
    const data: ClubsModel[] = JSON.parse(database);
    const index = data.findIndex(clubs => clubs.id === id);
    if (index !== -1){
        data.splice(index, 1);
        await fs.writeFile("./src/data/clubs.json", JSON.stringify(data));
        return true;
    } else {
        return false;
    }
};
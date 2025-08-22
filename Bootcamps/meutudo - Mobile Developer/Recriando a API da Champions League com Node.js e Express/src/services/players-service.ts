import { PlayerModel } from "../models/players-model";
import { StatisticsModel } from "../models/statisitcs-model";
import * as playersRepository from "../repositories/players-repository";
import * as HttpResponse from "../util/http-helper";

export const getPlayerService = async () => {
    const data = await playersRepository.findAllPlayers();
    let response = null;
    if (data){
        response = await HttpResponse.ok(data);
    } else {
        response = await HttpResponse.noContent();
    }
    return response;
};

export const getPlayerByIdService = async (id: number) => {
    const data = await playersRepository.findPlayerById(id);
    let response = null;
    if (data){
        response = await HttpResponse.ok(data);
    } else {
        response = await HttpResponse.noContent();
    }
    return response;
};

export const deletePlayerByIdService = async (id: number) => {
    let response = null;
    let confirm = await playersRepository.deleteOnePlayer(id);
    if (confirm){
        response = await HttpResponse.okDelete();
    } else {
        response = await HttpResponse.noContent();
    }
    return response;
};        

export const createPlayerService = async (player: PlayerModel) => {
    let response = null;
    if (Object.keys(player).length !== 0){
        await playersRepository.insertPlayer(player);
        response = await HttpResponse.created();
    } else {
        response = await HttpResponse.badRequest();
    }
    return response;
};

export const updatePlayerService = async(id: number, statistic: StatisticsModel) => {
    const data = await playersRepository.updataPlayerById(id, statistic);
    let response = null;
    if (Object.keys(data).length !== 0){
        response = await HttpResponse.ok(data);
    } else {
        response = await HttpResponse.badRequest();
    }
    return response;
};
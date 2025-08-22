import { ClubsModel } from "../models/clubs-model";
import * as clubsRepository from "../repositories/clubs-repository";
import * as HttpResponse from "../util/http-helper";

export const getClubsService = async () => {
    const data = await clubsRepository.findAllClubs();
    let response = null;
    if (Object.keys(data).length !== 0){
        response = await HttpResponse.ok(data);
    } else {
        response = await HttpResponse.noContent();
    }
    return response;
};

export const getClubByIdService = async (id: number) => {
    const data = await clubsRepository.findPlayerById(id);
    let response = null;
    if (data){
        response = await HttpResponse.ok(data);
    } else {
        response = await HttpResponse.noContent();
    }
    return response;
};

export const deleteClubByIdService = async (id: number) => {
    let response = null;
    let confirm = await clubsRepository.deleteOnePlayer(id);
    if (confirm){
        response = await HttpResponse.okDelete();
    } else {
        response = await HttpResponse.noContent();
    }
    return response;
};        

export const createClubService = async (player: ClubsModel) => {
    let response = null;
    if (Object.keys(player).length !== 0){
        await clubsRepository.insertPlayer(player);
        response = await HttpResponse.created();
    } else {
        response = await HttpResponse.badRequest();
    }
    return response;
};
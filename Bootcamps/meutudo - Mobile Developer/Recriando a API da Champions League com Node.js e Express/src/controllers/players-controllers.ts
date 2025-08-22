import { type Request, type Response } from "express";
import * as playerService from "../services/players-service";
import { noContent } from "../util/http-helper";
import { StatisticsModel } from "../models/statisitcs-model";

export const getPlayer = async (req: Request, res: Response) => {
    const httpResponse = await playerService.getPlayerService();
    res.status(httpResponse.statusCode).json(httpResponse.body);
};

export const getPlayerById = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const httpResponse = await playerService.getPlayerByIdService(id);
    res.status(httpResponse.statusCode).json(httpResponse.body);
};

export const deletePlayerById = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const httpResponse = await playerService.deletePlayerByIdService(id);
    res.status(httpResponse.statusCode).json(httpResponse.body);
};

export const updatePlayerById = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const bodyValue: StatisticsModel = req.body;
    const httpResponse = await playerService.updatePlayerService(id, bodyValue);
    res.status(httpResponse.statusCode).json(httpResponse.body);
};

export const createPlayer = async (req: Request, res: Response) => {
    const bodyValue = req.body;
    const httpResponse = await playerService.createPlayerService(bodyValue);
    if (httpResponse){
        res.status(httpResponse.statusCode).json(httpResponse.body);
    } else {
        const response = await noContent();
        res.status(response.statusCode).json(response.body);
    }
};
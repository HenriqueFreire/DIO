import { type Request, type Response } from "express";
import * as clubService from "../services/clubs-service";
import { noContent } from "../util/http-helper";

export const getClubs = async (req: Request, res: Response) => {
    const Response = await clubService.getClubsService();
    res.status(Response.statusCode).json(Response.body);
};

export const getClubById = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const httpResponse = await clubService.getClubByIdService(id);
    res.status(httpResponse.statusCode).json(httpResponse.body);
};

export const deleteClubById = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const httpResponse = await clubService.deleteClubByIdService(id);
    res.status(httpResponse.statusCode).json(httpResponse.body);
};

export const createClub = async (req: Request, res: Response) => {
    const bodyValue = req.body;
    const httpResponse = await clubService.createClubService(bodyValue);
    if (httpResponse){
        res.status(httpResponse.statusCode).json(httpResponse.body);
    } else {
        const response = await noContent();
        res.status(response.statusCode).json(response.body);
    }
};
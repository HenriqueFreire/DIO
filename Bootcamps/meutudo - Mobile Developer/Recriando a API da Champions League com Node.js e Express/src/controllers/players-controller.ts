import {  Request, Response } from 'express';
import * as PlayerService  from '../services/players-service';

export const getPlayers = async (req: Request, res: Response) => {
  const HttpResponse = await PlayerService.getPlayerService();
  res.status(HttpResponse.statusCode).json(HttpResponse.body);
}

export const getPlayerById = async (req: Request, res: Response) => {
  const playerId = parseInt(req.params.id);
  const HttpResponse = await PlayerService.getPlayerByIdService(playerId);

  res.status(HttpResponse.statusCode).json(HttpResponse.body);
}

export const postPlayer = async (req: Request, res: Response) => {
  const bodyValue = req.body;
  const HttpResponse = await PlayerService.createPlayerService(bodyValue);

  if(HttpResponse) {
    res.status(HttpResponse.statusCode).send(HttpResponse.body);
  } 
}
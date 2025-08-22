import { Router } from "express";
import * as playersControllers from "./controllers/players-controllers";
import * as clubsControllers from "./controllers/clubs-controllers";


export const router = Router();

router.get("/players", playersControllers.getPlayer);
router.post("/players", playersControllers.createPlayer);
router.get("/players/:id", playersControllers.getPlayerById);
router.delete("/players/:id", playersControllers.deletePlayerById);
router.patch("/players/:id", playersControllers.updatePlayerById);

router.get("/clubs", clubsControllers.getClubs);
router.post("/clubs", clubsControllers.createClub);
router.get("/clubs/:id", clubsControllers.getClubById);
router.delete("/clubs/:id", clubsControllers.deleteClubById);


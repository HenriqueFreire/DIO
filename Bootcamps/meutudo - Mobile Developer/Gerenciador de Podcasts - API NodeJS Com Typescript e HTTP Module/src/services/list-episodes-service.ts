import { PodcastTransferModel } from "../models/podcast-transfer-model";
import { repositoriesPodcasts } from "../repositories/podcast-repository"
import { StatusCodes } from "../utils/http-status-code";

export const serviceListEpisodes = async ():Promise<PodcastTransferModel> => {
  let responseFormat: PodcastTransferModel = {
     statusCode: 0,
     body: []
  };

  const data = await repositoriesPodcasts();
  
  responseFormat.statusCode = data.length > 0 ? StatusCodes.OK : StatusCodes.NO_CONTENT;
  responseFormat.body = data;
  
  return responseFormat;
}
      
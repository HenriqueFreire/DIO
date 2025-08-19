import { PodcastTransferModel } from "../models/podcast-transfer-model";
import { repositoriesPodcasts } from "../repositories/podcast-repository"
import { StatusCodes } from "../utils/http-status-code";

export const serviceFilterEpisodes = async (podcastName: string | undefined)
:Promise<PodcastTransferModel> => {
  let responseFormat: PodcastTransferModel = {
    statusCode: 0,
    body: []
  };

  const queryString = podcastName?.split('?p=')[1] || '';
  const data = await repositoriesPodcasts(queryString);

  responseFormat.statusCode = data.length > 0 ? StatusCodes.OK : StatusCodes.NO_CONTENT;
  responseFormat.body = data;
  
  return responseFormat;
}
import { Configuration, OpenAIApi } from "openai";
import dotenv from 'dotenv';

dotenv.config();

export default class openai{

	static configuration(): OpenAIApi{
		const configuration = new Configuration({
			apiKey: process.env.OPEN_AI_KEY,
		})

		return new OpenAIApi(configuration)
	}

	static textCompletion ({prompt}: {prompt: string}) {
    return 	{
			model:"text-davinci-003",
			prompt:`${prompt}`,
			temperature:0,
			max_tokens: 3500,
			top_p:1,
			frequency_penalty: 0.5,
			presence_penalty: 0
		}
  }
}

import InputPrompt from "../models/input-prompt";
import openai from "../config/openai";
import { Request, Response } from 'express';

export default {
	async sendText(req: Request, res: Response){

		const openaiAPI = openai.configuration()
		const inputModel = new InputPrompt(req.body)

		try {
			const response = await openaiAPI.createCompletion(
				openai.textCompletion(inputModel)
			)

			return res.status(200).json({
				sucess: true,
				data: response.data.choices[0].text
			})

		} catch (error: any) {

			return res.status(400).json({
				sucess: false,
				error: error.response && error.response.data
				? error.response.data
				: 'There was an issue on the server'
			})

		}
	}

}

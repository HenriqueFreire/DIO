import axios from 'axios';
const URL_API: string = 'http://localhost:5000/api/prompt'

interface MessagePayload {
  prompt: string;
}

interface ApiResponse {
  data: string; // Assuming the API returns a string that needs to be split by '\n'
}

export const makeRequest = async (message: MessagePayload): Promise<ApiResponse> => {
  console.log(message)
  const {data} = await axios.post<ApiResponse>(URL_API, message)
 
  return data
}

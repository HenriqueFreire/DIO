import { permittedCharacters } from "./utils/permittedChacacters.js";

export async function handle() {
  let characters = await permittedCharacters()
  const passwordLength = parseInt(process.env.PASSWORD_LENGTH);
  let password = "";
  
  

  for (let i = 0; i < passwordLength; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    password += characters[randomIndex];
  }
  
  return password;
}

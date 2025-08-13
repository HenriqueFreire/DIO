import chalk from "chalk";
import { handle } from "./handle.js";

export async function createPassword(){
  console.log(chalk.green("Password"));
  const password = await handle();
  console.log(chalk.blue(`Generated Password: ${password}`));
}
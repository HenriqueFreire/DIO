import chalk from "chalk";

export const promptQRCode = [
  {
    name: "link",
    description: chalk.yellow("Digite o link que deseja gerar o QR Code"),
  },
  {
    name: "type",
    description: chalk.yellow("Escolha o tipo de QR Code (1 - NORMAL, (2 - TERMINAL"),
    pattern: /^[1-2]$/,
    message: chalk.red.italic("Escolha apenas entre 1 ou 2"),
    require: true,
  }
];
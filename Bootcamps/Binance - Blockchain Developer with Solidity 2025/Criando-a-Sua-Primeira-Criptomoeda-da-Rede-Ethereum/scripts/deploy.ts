import { ethers } from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Fazendo deploy do contrato com a conta:", deployer.address);

    const token = await ethers.deployContract("ZeDaManga");

    await token.waitForDeployment();

    console.log("ZeDaManga implantado em:", await token.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

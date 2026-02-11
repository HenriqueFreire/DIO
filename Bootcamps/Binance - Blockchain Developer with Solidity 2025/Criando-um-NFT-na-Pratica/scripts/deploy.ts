import { ethers } from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Fazendo deploy com a conta:", deployer.address);

    const MyNFT = await ethers.getContractFactory("MyNFT");
    const nft = await MyNFT.deploy();

    await nft.deployed();
    const address = nft.address;

    console.log("NFT disparado para o endereço:", address);

    // Mintando um NFT de exemplo
    const tokenURI = "https://gateway.pinata.cloud/ipfs/QmZ4tjB7uS3o1E8uV6XfG4jS3E"; // Link de exemplo
    console.log("Cunhando o primeiro NFT...");
    const tx = await nft.mintNFT(deployer.address, tokenURI);
    await tx.wait();

    console.log("NFT cunhado com sucesso para:", deployer.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});



// Contract Address and ABI - these will be loaded dynamically or from a generated file
let contractAddress; // Will be loaded from contract-address.json
let contractABI;     // Will be loaded from PokemonNFT.abi

let pokemonNFTContract;
let signer;
let provider;

const connectWalletBtn = document.getElementById("connectWallet");
const walletAddressElem = document.getElementById("walletAddress");
const ownedPokemonList = document.getElementById("ownedPokemon");

async function connectWallet() {
    if (typeof window.ethereum !== "undefined") {
        try {
            await window.ethereum.request({ method: "eth_requestAccounts" });
            provider = new ethers.BrowserProvider(window.ethereum);
            signer = await provider.getSigner();
            const address = await signer.getAddress();
            walletAddressElem.textContent = `Connected: ${address}`;
            console.log("Metamask connected:", address);

            // Load contract details after wallet is connected
            await loadContractDetails();
            if (contractAddress && contractABI) {
                pokemonNFTContract = new ethers.Contract(contractAddress, contractABI, signer);
                console.log("PokemonNFT Contract connected:", pokemonNFTContract);
                // Now you can call contract functions, e.g., display owned Pokémon
                displayOwnedPokemon();
            } else {
                console.error("Contract address or ABI not loaded.");
            }

        } catch (error) {
            console.error("User denied account access or other error:", error);
            walletAddressElem.textContent = "Connection failed.";
        }
    } else {
        alert("Metamask is not installed. Please install it to use this DApp.");
    }
}

async function loadContractDetails() {
    try {
        const addressResponse = await fetch("../deploy/contract-address.json");
        const addressData = await addressResponse.json();
        contractAddress = addressData.PokemonNFT;

        const abiResponse = await fetch("../PokemonNFT.abi");
        contractABI = await abiResponse.json();

        console.log("Contract Address:", contractAddress);
        console.log("Contract ABI loaded.");
    } catch (error) {
        console.error("Error loading contract details:", error);
    }
}

async function displayOwnedPokemon() {
    ownedPokemonList.innerHTML = "";
    if (!pokemonNFTContract || !signer) {
        console.error("Contract or signer not initialized.");
        return;
    }

    try {
        const address = await signer.getAddress();
        const balance = await pokemonNFTContract.balanceOf(address);
        console.log(`Balance for ${address}: ${balance}`);

        for (let i = 0; i < balance; i++) {
            const tokenId = await pokemonNFTContract.tokenOfOwnerByIndex(address, i);
            const pokemon = await pokemonNFTContract.getPokemon(tokenId);
            
            const listItem = document.createElement("li");
            listItem.textContent = `ID: ${tokenId}, Name: ${pokemon.name}, Type: ${pokemon.pokemonType}, HP: ${pokemon.hp}, Attack: ${pokemon.attack}, Defense: ${pokemon.defense}`;
            // Add image later with IPFS
            ownedPokemonList.appendChild(listItem);
        }

    } catch (error) {
        console.error("Error fetching owned Pokémon:", error);
    }
}


connectWalletBtn.addEventListener("click", connectWallet);

// Initial load (if Metamask is already connected)
// This part might need adjustment depending on how you want to handle initial connection state
// window.ethereum.on('accountsChanged', (accounts) => {
//     if (accounts.length === 0) {
//         walletAddressElem.textContent = "Not Connected";
//         ownedPokemonList.innerHTML = "";
//         console.log("Metamask disconnected.");
//     } else {
//         connectWallet(); // Reconnect and update UI
//     }
// });

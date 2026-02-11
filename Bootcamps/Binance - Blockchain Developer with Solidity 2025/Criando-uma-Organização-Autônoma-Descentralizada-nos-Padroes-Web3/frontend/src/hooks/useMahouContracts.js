import { useMemo } from 'react';
import { ethers } from 'ethers';
import { useWeb3 } from '../context/Web3Context';

// ABIs simplificadas para as funções que vamos usar
const TOKEN_ABI = [
    "function balanceOf(address owner) view returns (uint256)",
    "function decimals() view returns (uint8)",
    "function symbol() view returns (string)",
    "function totalSupply() view returns (uint256)",
    "function createSellOffer(uint256 amount, uint256 price) returns (uint256)"
];

const TREASURY_ABI = [
    "function mahouToken() view returns (address)",
    "function currentCycleProfit() view returns (uint256)",
    "function getCyclesCount() view returns (uint256)",
    "function withdrawFromCycle(uint256 cycleId) returns (bool)",
    "function hasWithdrawnFromCycle(uint256 cycleId, address investor) view returns (bool)"
];

const TOKEN_ADDRESS = "0x..."; // A ser preenchido após deploy
const TREASURY_ADDRESS = "0x..."; // A ser preenchido após deploy

export const useMahouContracts = () => {
    const { signer, provider } = useWeb3();

    const tokenContract = useMemo(() => {
        if (!provider) return null;
        return new ethers.Contract(TOKEN_ADDRESS, TOKEN_ABI, signer || provider);
    }, [signer, provider]);

    const treasuryContract = useMemo(() => {
        if (!provider) return null;
        return new ethers.Contract(TREASURY_ADDRESS, TREASURY_ABI, signer || provider);
    }, [signer, provider]);

    return { tokenContract, treasuryContract };
};

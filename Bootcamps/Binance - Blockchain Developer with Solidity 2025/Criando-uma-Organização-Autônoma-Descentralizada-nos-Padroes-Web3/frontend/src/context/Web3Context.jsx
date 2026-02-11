import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { ethers } from 'ethers';

const Web3Context = createContext();

export const useWeb3 = () => useContext(Web3Context);

export const Web3Provider = ({ children }) => {
    const [account, setAccount] = useState(null);
    const [provider, setProvider] = useState(null);
    const [signer, setSigner] = useState(null);
    const [chainId, setChainId] = useState(null);
    const [error, setError] = useState(null);

    const connectWallet = useCallback(async () => {
        if (window.ethereum) {
            try {
                const browserProvider = new ethers.BrowserProvider(window.ethereum);
                const accounts = await browserProvider.send("eth_requestAccounts", []);
                const signerInstance = await browserProvider.getSigner();
                const network = await browserProvider.getNetwork();

                setAccount(accounts[0]);
                setProvider(browserProvider);
                setSigner(signerInstance);
                setChainId(network.chainId);
                setError(null);
            } catch (err) {
                console.error("Erro ao conectar carteira:", err);
                setError("Falha ao conectar carteira.");
            }
        } else {
            setError("MetaMask não detectada.");
        }
    }, []);

    useEffect(() => {
        if (window.ethereum) {
            window.ethereum.on('accountsChanged', (accounts) => {
                if (accounts.length > 0) {
                    setAccount(accounts[0]);
                } else {
                    setAccount(null);
                    setSigner(null);
                }
            });

            window.ethereum.on('chainChanged', () => {
                window.location.reload();
            });
        }
    }, []);

    return (
        <Web3Context.Provider value={{ account, provider, signer, chainId, connectWallet, error }}>
            {children}
        </Web3Context.Provider>
    );
};

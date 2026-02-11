import { Web3Provider } from './context/Web3Context';

function App() {
    return (
        <Web3Provider>
            <Dashboard />
        </Web3Provider>
    );
}

import React, { useState, useEffect } from 'react';
import { useWeb3 } from './context/Web3Context';
import { useMahouContracts } from './hooks/useMahouContracts';
import { ethers } from 'ethers';

function Dashboard() {
    const { account, connectWallet, error } = useWeb3();
    const { tokenContract, treasuryContract } = useMahouContracts();
    const [lastPaymentDate, setLastPaymentDate] = useState("10/02/2026");
    const [nextPaymentDate, setNextPaymentDate] = useState("10/03/2026");
    const [accumulatedProfit, setAccumulatedProfit] = useState("0.00");
    const [userBalance, setUserBalance] = useState("0");

    useEffect(() => {
        const fetchData = async () => {
            if (treasuryContract) {
                try {
                    const profit = await treasuryContract.currentCycleProfit();
                    setAccumulatedProfit(ethers.formatEther(profit));
                } catch (err) {
                    console.error("Erro ao buscar lucro:", err);
                }
            }
            if (tokenContract && account) {
                try {
                    const balance = await tokenContract.balanceOf(account);
                    const decimals = await tokenContract.decimals();
                    setUserBalance(ethers.formatUnits(balance, decimals));
                } catch (err) {
                    console.error("Erro ao buscar saldo:", err);
                }
            }
        };

        fetchData();
        const interval = setInterval(fetchData, 15000); // Atualiza a cada 15s
        return () => clearInterval(interval);
    }, [tokenContract, treasuryContract, account]);

    const investors = [
        { name: "Fundador (Mahou)", stake: "88%", tokens: "880.000", color: "#9b4dff" },
        { name: "Investidor A", stake: "10%", tokens: "100.000", color: "#00f2ff" },
        { name: "Investidor B", stake: "2%", tokens: "20.000", color: "#ff4d9b" },
    ];

    return (
        <div className="container" style={{ padding: '40px', maxWidth: '1200px', margin: '0 auto' }}>
            <header style={{ marginBottom: '60px', textAlign: 'center' }}>
                <h1 className="title-gradient" style={{ fontSize: '3.5rem', marginBottom: '10px' }}>MAHOU TECHNOLOGIES</h1>
                <p style={{ color: 'var(--text-dim)', fontSize: '1.2rem' }}>Dashboard de Governança e Distribuição de Lucros</p>
                {account && <p style={{ color: 'var(--primary)', marginTop: '10px' }}>Conectado: {account.substring(0, 6)}...{account.substring(38)}</p>}
                {error && <p style={{ color: '#ff4d4d', marginTop: '10px' }}>{error}</p>}
            </header>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '30px', marginBottom: '50px' }}>
                <div className="glass-card">
                    <h3 style={{ color: 'var(--text-dim)', marginBottom: '15px', textTransform: 'uppercase', fontSize: '0.8rem' }}>Último Pagamento</h3>
                    <p style={{ fontSize: '2rem', fontWeight: 'bold' }}>{lastPaymentDate}</p>
                </div>
                <div className="glass-card" style={{ borderLeft: '4px solid var(--primary)' }}>
                    <h3 style={{ color: 'var(--text-dim)', marginBottom: '15px', textTransform: 'uppercase', fontSize: '0.8rem' }}>Próximo Pagamento (Previsto)</h3>
                    <p style={{ fontSize: '2rem', fontWeight: 'bold' }}>{nextPaymentDate}</p>
                </div>
                <div className="glass-card">
                    <h3 style={{ color: 'var(--text-dim)', marginBottom: '15px', textTransform: 'uppercase', fontSize: '0.8rem' }}>Lucro Acumulado no Ciclo</h3>
                    <p style={{ fontSize: '2rem', fontWeight: 'bold', color: '#00ff88' }}>{accumulatedProfit} ETH</p>
                </div>
            </div>

            <div className="glass-card" style={{ marginBottom: '50px' }}>
                <h2 style={{ marginBottom: '30px' }}>Distribuição dos Investidores</h2>
                <div style={{ display: 'flex', height: '30px', borderRadius: '15px', overflow: 'hidden', marginBottom: '40px' }}>
                    {investors.map((inv, i) => (
                        <div
                            key={i}
                            style={{ width: inv.stake, backgroundColor: inv.color, transition: 'width 0.5s ease' }}
                            title={inv.name}
                        />
                    ))}
                </div>

                <table style={{ width: '100%', borderCollapse: 'collapse', color: 'var(--text-main)' }}>
                    <thead>
                        <tr style={{ textAlign: 'left', borderBottom: '1px solid var(--glass-border)' }}>
                            <th style={{ padding: '15px' }}>Investidor</th>
                            <th style={{ padding: '15px' }}>Participação (%)</th>
                            <th style={{ padding: '15px' }}>Tokens MAHOU</th>
                            <th style={{ padding: '15px' }}>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        {investors.map((inv, i) => (
                            <tr key={i} style={{ borderBottom: '1px solid var(--glass-border)' }}>
                                <td style={{ padding: '15px', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <div style={{ width: '10px', height: '10px', borderRadius: '50%', backgroundColor: inv.color }}></div>
                                    {inv.name}
                                </td>
                                <td style={{ padding: '15px' }}>{inv.stake}</td>
                                <td style={{ padding: '15px' }}>{inv.name === "Seu Saldo" ? userBalance : inv.tokens}</td>
                                <td style={{ padding: '15px' }}>
                                    <span style={{ padding: '4px 8px', borderRadius: '4px', backgroundColor: 'rgba(0, 255, 136, 0.1)', color: '#00ff88', fontSize: '0.8rem' }}>Ativo</span>
                                </td>
                            </tr>
                        ))}
                        {account && (
                            <tr style={{ borderBottom: '1px solid var(--glass-border)', backgroundColor: 'rgba(155, 77, 255, 0.05)' }}>
                                <td style={{ padding: '15px', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <div style={{ width: '10px', height: '10px', borderRadius: '50%', backgroundColor: 'var(--primary)' }}></div>
                                    Sua Carteira
                                </td>
                                <td style={{ padding: '15px' }}>-</td>
                                <td style={{ padding: '15px' }}>{parseFloat(userBalance).toLocaleString()} MAHOU</td>
                                <td style={{ padding: '15px' }}>
                                    <span style={{ padding: '4px 8px', borderRadius: '4px', backgroundColor: 'rgba(0, 255, 136, 0.1)', color: '#00ff88', fontSize: '0.8rem' }}>Conectado</span>
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>

            <footer style={{ textAlign: 'center', color: 'var(--text-dim)', fontSize: '0.9rem' }}>
                <p>&copy; 2026 Mahou Technologies. Operando via Smart Contracts na Blockchain.</p>
                {!account ? (
                    <button className="btn-primary" style={{ marginTop: '20px' }} onClick={connectWallet}>
                        Conectar Carteira Web3
                    </button>
                ) : (
                    <div style={{ marginTop: '20px' }}>
                        <button className="btn-primary" style={{ marginRight: '10px' }}>Sacar Lucros</button>
                        <button className="btn-primary" style={{ backgroundColor: '#444' }}>Nova Oferta de Venda</button>
                    </div>
                )}
            </footer>
        </div>
    );
}

export default App;

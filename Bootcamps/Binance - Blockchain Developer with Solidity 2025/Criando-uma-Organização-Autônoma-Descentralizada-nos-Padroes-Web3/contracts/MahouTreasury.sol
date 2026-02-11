// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

interface IMahouToken is IERC20 {
    // Funções de snapshot removidas
}

/**
 * @title MahouTreasury
 * @dev Tesouraria com Ciclos de Lucro simplificados.
 */
contract MahouTreasury is Ownable, ReentrancyGuard {
    IMahouToken public mahouToken;
    
    struct Cycle {
        uint256 totalProfit;
        bool distributed;
    }

    Cycle[] public cycles;
    uint256 public currentCycleProfit;
    
    // mapping(cycleId => mapping(investor => hasWithdrawn))
    mapping(uint256 => mapping(address => bool)) public hasWithdrawnFromCycle;

    event CycleClosed(uint256 indexed cycleId, uint256 amount);
    event ProfitWithdrawn(uint256 indexed cycleId, address indexed investor, uint256 amount);

    constructor(address _tokenAddress, address _initialOwner) Ownable(_initialOwner) {
        mahouToken = IMahouToken(_tokenAddress);
    }

    receive() external payable {
        currentCycleProfit += msg.value;
    }

    /**
     * @dev O fundador fecha o ciclo atual (ex: fim do trimestre).
     * Fixa o lucro a ser distribuído.
     */
    function closeCycle() external onlyOwner {
        uint256 cycleId = cycles.length;
        
        cycles.push(Cycle({
            totalProfit: currentCycleProfit,
            distributed: true
        }));

        emit CycleClosed(cycleId, currentCycleProfit);
        currentCycleProfit = 0;
    }

    /**
     * @dev Investidores sacam o lucro de um ciclo específico.
     * O cálculo usa o saldo ATUAL do investidor.
     */
    function withdrawFromCycle(uint256 cycleId) external nonReentrant {
        require(cycleId < cycles.length, "Ciclo inexistente");
        require(!hasWithdrawnFromCycle[cycleId][msg.sender], "Lucro ja sacado para este ciclo");

        Cycle storage cycle = cycles[cycleId];
        uint256 currentBalance = mahouToken.balanceOf(msg.sender);
        require(currentBalance > 0, "Sem participacao");

        uint256 totalSupply = mahouToken.totalSupply();
        uint256 amountToWithdraw = (cycle.totalProfit * currentBalance) / totalSupply;

        hasWithdrawnFromCycle[cycleId][msg.sender] = true;
        
        (bool success, ) = payable(msg.sender).call{value: amountToWithdraw}("");
        require(success, "Falha no envio de ETH");

        emit ProfitWithdrawn(cycleId, msg.sender, amountToWithdraw);
    }

    function getCyclesCount() external view returns (uint256) {
        return cycles.length;
    }
}

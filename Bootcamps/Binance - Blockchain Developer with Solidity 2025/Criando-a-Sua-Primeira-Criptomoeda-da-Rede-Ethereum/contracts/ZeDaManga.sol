// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ZeDaManga {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    uint256 private constant TOTAL_SUPPLY = 1000000 * 10**18;

    constructor() {
        // Mint inicial (Assembly)
        assembly {
            // Mapeamento de balance: keccak256(owner . slot)
            // Slot 0 para balances (arbitrário neste exemplo puro assembly, mas vamos usar logica padrao)
            // Na verdade, storage layout manual
            // Slot 0: Balances
            // Slot 1: Allowances
            // Slot 2: TotalSupply (mas é constante no codigo, nao precisa storage se for imutavel)
            
            // Mas para simplificar e seguir padrao:
            // Vamos armazenar o balance do msg.sender
            
            let owner := caller()
            let amount := TOTAL_SUPPLY
            
            // Store balance
            mstore(0, owner)
            mstore(32, 0) // Slot 0
            let slot := keccak256(0, 64)
            sstore(slot, amount)
            
            // Emit Transfer(0, owner, amount)
            mstore(0, amount)
            log3(0, 32, 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef, 0, owner)
        }
    }

    fallback() external payable {
        assembly {
            // Seletor de função (primeiros 4 bytes do calldata)
            let selector := shr(224, calldataload(0))

            // Dispatcher
            switch selector
            case 0x70a08231 { // balanceOf(address)
                let owner := calldataload(4)
                mstore(0, owner)
                mstore(32, 0) // Slot 0
                let slot := keccak256(0, 64)
                let bal := sload(slot)
                mstore(0, bal)
                return(0, 32)
            }
            case 0xa9059cbb { // transfer(address,uint256)
                let to := calldataload(4)
                let amount := calldataload(36)
                let from := caller()

                // Subtrair do remetente
                mstore(0, from)
                mstore(32, 0)
                let fromSlot := keccak256(0, 64)
                let fromBal := sload(fromSlot)

                if lt(fromBal, amount) {
                    revert(0, 0)
                }
                sstore(fromSlot, sub(fromBal, amount))

                // Adicionar ao destinatário
                mstore(0, to)
                mstore(32, 0)
                let toSlot := keccak256(0, 64)
                let toBal := sload(toSlot)
                sstore(toSlot, add(toBal, amount))

                // Evento Transfer
                mstore(0, amount)
                log3(0, 32, 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef, from, to)

                // Retornar true
                mstore(0, 1)
                return(0, 32)
            }
            case 0x18160ddd { // totalSupply()
                mstore(0, TOTAL_SUPPLY)
                return(0, 32)
            }
            case 0x06fdde03 { // name()
                // Retornar "ZeDaManga"
                mstore(0, 0x20) // Offset
                mstore(32, 9)   // Length
                mstore(64, 0x5a6544614d616e67610000000000000000000000000000000000000000000000) // "ZeDaManga"
                return(0, 96)
            }
            case 0x95d89b41 { // symbol()
                // Retornar "ZDM"
                mstore(0, 0x20)
                mstore(32, 3) 
                mstore(64, 0x5a444d0000000000000000000000000000000000000000000000000000000000) // "ZDM"
                return(0, 96)
            }
            case 0x313ce567 { // decimals()
                mstore(0, 18)
                return(0, 32)
            }
            default {
                revert(0, 0)
            }
        }
    }
}

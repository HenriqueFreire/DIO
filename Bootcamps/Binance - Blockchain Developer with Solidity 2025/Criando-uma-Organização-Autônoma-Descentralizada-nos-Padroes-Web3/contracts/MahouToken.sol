// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MahouToken
 * @dev Token de participação com Direito de Preferência (ROFR).
 */
contract MahouToken is ERC20, Ownable {
    
    struct SellOffer {
        address seller;
        uint256 amount;
        uint256 price;
        uint256 timestamp;
        bool active;
    }

    mapping(uint256 => SellOffer) public sellOffers;
    uint256 public nextOfferId;
    uint256 public constant ROFR_PERIOD = 3 days;

    event OfferCreated(uint256 indexed offerId, address indexed seller, uint256 amount, uint256 price);
    event OfferAcceptedByFounder(uint256 indexed offerId, address indexed founder);
    event OfferMatured(uint256 indexed offerId);

    constructor(address initialOwner) ERC20("Mahou Participation Token", "MAHOU") Ownable(initialOwner) {
        _mint(initialOwner, 1000000 * 10 ** decimals());
    }

    // O fundador pode mintar mais tokens se a empresa precisar de mais investimento
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Um investidor manifesta interesse em vender tokens.
     * Isso inicia o período de Direito de Preferência do fundador.
     */
    function createSellOffer(uint256 amount, uint256 price) external returns (uint256) {
        require(balanceOf(msg.sender) >= amount, "Saldo insuficiente");
        
        uint256 offerId = nextOfferId++;
        sellOffers[offerId] = SellOffer({
            seller: msg.sender,
            amount: amount,
            price: price,
            timestamp: block.timestamp,
            active: true
        });

        emit OfferCreated(offerId, msg.sender, amount, price);
        return offerId;
    }

    /**
     * @dev O fundador exerce seu Direito de Preferência.
     * Para simplificar, o pagamento do preço deve ser tratado off-chain ou em outro contrato,
     * aqui apenas transferimos os tokens se o fundador validar.
     */
    function founderBuy(uint256 offerId) external onlyOwner {
        SellOffer storage offer = sellOffers[offerId];
        require(offer.active, "Oferta inativa");
        require(block.timestamp <= offer.timestamp + ROFR_PERIOD, "Periodo ROFR expirado");

        offer.active = false;
        _transfer(offer.seller, owner(), offer.amount);
        
        emit OfferAcceptedByFounder(offerId, msg.sender);
    }
}

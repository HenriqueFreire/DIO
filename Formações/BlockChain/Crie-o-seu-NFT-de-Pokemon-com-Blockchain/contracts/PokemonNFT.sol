// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PokemonNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    struct Pokemon {
        string name;
        string pokemonType; // e.g., "Fire", "Water", "Grass"
        uint256 hp;
        uint256 attack;
        uint256 defense;
        string imageUrl; // IPFS hash or URL for image
    }

    mapping(uint256 => Pokemon) public pokemonData;

    struct Battle {
        uint256 pokemon1Id;
        uint256 pokemon2Id;
        address player1;
        address player2;
        uint256 pokemon1Hp;
        uint256 pokemon2Hp;
        uint256 currentTurn;
        bool active;
    }

    Counters.Counter private _battleIdCounter;
    mapping(uint256 => Battle) public battles;

    event BattleStarted(uint256 indexed battleId, address indexed player1, address indexed player2, uint256 pokemon1Id, uint256 pokemon2Id);
    event AttackPerformed(uint256 indexed battleId, uint256 indexed attackerPokemonId, uint256 indexed defenderPokemonId, uint256 damage, uint256 remainingHp);
    event BattleEnded(uint256 indexed battleId, address indexed winner, address indexed loser, uint256 winnerPokemonId, uint256 loserPokemonId);

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
        Ownable(msg.sender)
    {}

    function safeMint(address to, string memory _name, string memory _pokemonType, uint256 _hp, uint256 _attack, uint256 _defense, string memory _imageUrl)
        public
        onlyOwner
    {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);

        pokemonData[tokenId] = Pokemon(
            _name,
            _pokemonType,
            _hp,
            _attack,
            _defense,
            _imageUrl
        );
    }

    // Function to get Pokemon details by tokenId (optional, as pokemonData is public)
    function getPokemon(uint256 tokenId) public view returns (string memory name, string memory pokemonType, uint256 hp, uint256 attack, uint256 defense, string memory imageUrl) {
        Pokemon storage pokemon = pokemonData[tokenId];
        return (pokemon.name, pokemon.pokemonType, pokemon.hp, pokemon.attack, pokemon.defense, pokemon.imageUrl);
    }

    function startBattle(uint256 _pokemon1Id, uint256 _pokemon2Id) public {
        require(ownerOf(_pokemon1Id) == msg.sender, "Caller is not owner of Pokemon 1");
        require(ownerOf(_pokemon2Id) == msg.sender, "Caller is not owner of Pokemon 2");
        require(_pokemon1Id != _pokemon2Id, "Cannot battle with the same Pokemon");

        uint256 battleId = _battleIdCounter.current();
        _battleIdCounter.increment();

        Pokemon storage pokemon1 = pokemonData[_pokemon1Id];
        Pokemon storage pokemon2 = pokemonData[_pokemon2Id];

        battles[battleId] = Battle({
            pokemon1Id: _pokemon1Id,
            pokemon2Id: _pokemon2Id,
            player1: msg.sender, // For now, assuming single player battle
            player2: msg.sender, // For now, assuming single player battle
            pokemon1Hp: pokemon1.hp,
            pokemon2Hp: pokemon2.hp,
            currentTurn: 0,
            active: true
        });

        emit BattleStarted(battleId, msg.sender, msg.sender, _pokemon1Id, _pokemon2Id);
    }

    function attack(uint256 _battleId, uint256 _attackerPokemonId, uint256 _defenderPokemonId) public {
        Battle storage battle = battles[_battleId];
        require(battle.active, "Battle is not active");
        require(msg.sender == battle.player1 || msg.sender == battle.player2, "Only players in the battle can attack");

        // Determine attacker and defender based on current turn (simplified for now)
        // For now, let's assume player1's pokemon1Id attacks first, then player2's pokemon2Id
        // This will need more sophisticated turn management later
        require((msg.sender == battle.player1 && _attackerPokemonId == battle.pokemon1Id && _defenderPokemonId == battle.pokemon2Id) ||
                (msg.sender == battle.player2 && _attackerPokemonId == battle.pokemon2Id && _defenderPokemonId == battle.pokemon1Id),
                "Invalid attacker or defender for this turn");


        Pokemon storage attackerPokemon = pokemonData[_attackerPokemonId];
        Pokemon storage defenderPokemon = pokemonData[_defenderPokemonId];

        uint256 damage = attackerPokemon.attack > defenderPokemon.defense ? attackerPokemon.attack - defenderPokemon.defense : 0;

        if (_defenderPokemonId == battle.pokemon1Id) {
            battle.pokemon1Hp = battle.pokemon1Hp > damage ? battle.pokemon1Hp - damage : 0;
            emit AttackPerformed(_battleId, _attackerPokemonId, _defenderPokemonId, damage, battle.pokemon1Hp);
            if (battle.pokemon1Hp == 0) {
                battle.active = false;
                emit BattleEnded(_battleId, battle.player2, battle.player1, battle.pokemon2Id, battle.pokemon1Id);
            }
        } else if (_defenderPokemonId == battle.pokemon2Id) {
            battle.pokemon2Hp = battle.pokemon2Hp > damage ? battle.pokemon2Hp - damage : 0;
            emit AttackPerformed(_battleId, _attackerPokemonId, _defenderPokemonId, damage, battle.pokemon2Hp);
            if (battle.pokemon2Hp == 0) {
                battle.active = false;
                emit BattleEnded(_battleId, battle.player1, battle.player2, battle.pokemon1Id, battle.pokemon2Id);
            }
        }
        // TODO: Implement more complex turn management and attack rules
    }

contract PokemonNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    struct Pokemon {
        string name;
        string pokemonType; // e.g., "Fire", "Water", "Grass"
        uint256 hp;
        uint256 attack;
        uint256 defense;
        string imageUrl; // IPFS hash or URL for image
    }

    mapping(uint256 => Pokemon) public pokemonData;

    struct Battle {
        uint256 pokemon1Id;
        uint256 pokemon2Id;
        address player1;
        address player2;
        uint256 pokemon1Hp;
        uint256 pokemon2Hp;
        uint256 currentTurn;
        bool active;
    }

    Counters.Counter private _battleIdCounter;
    mapping(uint256 => Battle) public battles;

    event BattleStarted(uint256 indexed battleId, address indexed player1, address indexed player2, uint256 pokemon1Id, uint256 pokemon2Id);
    event AttackPerformed(uint256 indexed battleId, uint256 indexed attackerPokemonId, uint256 indexed defenderPokemonId, uint256 damage, uint256 remainingHp);
    event BattleEnded(uint256 indexed battleId, address indexed winner, address indexed loser, uint256 winnerPokemonId, uint256 loserPokemonId);

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
        Ownable(msg.sender)
    {}

    function safeMint(address to, string memory _name, string memory _pokemonType, uint256 _hp, uint256 _attack, uint256 _defense, string memory _imageUrl)
        public
        onlyOwner
    {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        _safeMint(to, tokenId);

        pokemonData[tokenId] = Pokemon(
            _name,
            _pokemonType,
            _hp,
            _attack,
            _defense,
            _imageUrl
        );
    }

    // Function to get Pokemon details by tokenId (optional, as pokemonData is public)
    function getPokemon(uint256 tokenId) public view returns (string memory name, string memory pokemonType, uint256 hp, uint256 attack, uint256 defense, string memory imageUrl) {
        Pokemon storage pokemon = pokemonData[tokenId];
        return (pokemon.name, pokemon.pokemonType, pokemon.hp, pokemon.attack, pokemon.defense, pokemon.imageUrl);
    }

    function startBattle(uint256 _pokemon1Id, uint256 _pokemon2Id) public {
        require(ownerOf(_pokemon1Id) == msg.sender, "Caller is not owner of Pokemon 1");
        require(ownerOf(_pokemon2Id) == msg.sender, "Caller is not owner of Pokemon 2");
        require(_pokemon1Id != _pokemon2Id, "Cannot battle with the same Pokemon");

        uint256 battleId = _battleIdCounter.current();
        _battleIdCounter.increment();

        Pokemon storage pokemon1 = pokemonData[_pokemon1Id];
        Pokemon storage pokemon2 = pokemonData[_pokemon2Id];

        battles[battleId] = Battle({
            pokemon1Id: _pokemon1Id,
            pokemon2Id: _pokemon2Id,
            player1: msg.sender, // For now, assuming single player battle
            player2: msg.sender, // For now, assuming single player battle
            pokemon1Hp: pokemon1.hp,
            pokemon2Hp: pokemon2.hp,
            currentTurn: 0,
            active: true
        });

        emit BattleStarted(battleId, msg.sender, msg.sender, _pokemon1Id, _pokemon2Id);
    }

    function attack(uint256 _battleId, uint256 _attackerPokemonId, uint256 _defenderPokemonId) public {
        Battle storage battle = battles[_battleId];
        require(battle.active, "Battle is not active");
        require(msg.sender == battle.player1 || msg.sender == battle.player2, "Only players in the battle can attack");

        // Determine attacker and defender based on current turn (simplified for now)
        // For now, let's assume player1's pokemon1Id attacks first, then player2's pokemon2Id
        // This will need more sophisticated turn management later
        require((msg.sender == battle.player1 && _attackerPokemonId == battle.pokemon1Id && _defenderPokemonId == battle.pokemon2Id) ||
                (msg.sender == battle.player2 && _attackerPokemonId == battle.pokemon2Id && _defenderPokemonId == battle.pokemon1Id),
                "Invalid attacker or defender for this turn");


        Pokemon storage attackerPokemon = pokemonData[_attackerPokemonId];
        Pokemon storage defenderPokemon = pokemonData[_defenderPokemonId];

        uint256 damage = attackerPokemon.attack > defenderPokemon.defense ? attackerPokemon.attack - defenderPokemon.defense : 0;

        if (_defenderPokemonId == battle.pokemon1Id) {
            battle.pokemon1Hp = battle.pokemon1Hp > damage ? battle.pokemon1Hp - damage : 0;
            emit AttackPerformed(_battleId, _attackerPokemonId, _defenderPokemonId, damage, battle.pokemon1Hp);
            if (battle.pokemon1Hp == 0) {
                battle.active = false;
                emit BattleEnded(_battleId, battle.player2, battle.player1, battle.pokemon2Id, battle.pokemon1Id);
            }
        } else if (_defenderPokemonId == battle.pokemon2Id) {
            battle.pokemon2Hp = battle.pokemon2Hp > damage ? battle.pokemon2Hp - damage : 0;
            emit AttackPerformed(_battleId, _attackerPokemonId, _defenderPokemonId, damage, battle.pokemon2Hp);
            if (battle.pokemon2Hp == 0) {
                battle.active = false;
                emit BattleEnded(_battleId, battle.player1, battle.player2, battle.pokemon1Id, battle.pokemon2Id);
            }
        }
        // TODO: Implement more complex turn management and attack rules
    }
}

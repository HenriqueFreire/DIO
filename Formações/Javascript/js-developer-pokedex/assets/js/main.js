const pokemonList = document.getElementById('pokemonList')
const loadMoreButton = document.getElementById('loadMoreButton')
const pokemonSearchInput = document.getElementById('pokemonSearch') // Get reference to the search input

const maxRecords = 151
const limit = 10
let offset = 0;
let allPokemons = []; // Array to store all loaded pokemons

function convertPokemonToLi(pokemon) {
    return `
        <li class="pokemon ${pokemon.type}" data-pokemon-number="${pokemon.number}">
            <span class="number">#${pokemon.number}</span>
            <span class="name">${pokemon.name}</span>

            <div class="detail">
                <ol class="types">
                    ${pokemon.types.map((type) => `<li class="type ${type}">${type}</li>`).join('')}
                </ol>

                <img src="${pokemon.photo}"
                     alt="${pokemon.name}">
            </div>
        </li>
    `
}

function renderPokemonList(pokemonsToRender) {
    pokemonList.innerHTML = pokemonsToRender.map(convertPokemonToLi).join('');
}

function loadPokemonItens(offset, limit) {
    pokeApi.getPokemons(offset, limit).then((pokemons = []) => {
        allPokemons = allPokemons.concat(pokemons); // Add new pokemons to the allPokemons array
        renderPokemonList(allPokemons); // Render the complete list of allPokemons
    })
}

loadPokemonItens(offset, limit)

pokemonSearchInput.addEventListener('input', (event) => {
    const searchValue = event.target.value.toLowerCase();
    const filteredPokemons = allPokemons.filter(pokemon =>
        pokemon.name.toLowerCase().includes(searchValue)
    );
    renderPokemonList(filteredPokemons);
});

pokemonList.addEventListener('click', (event) => {
    const clickedItem = event.target.closest('.pokemon');
    if (clickedItem) {
        const pokemonNumber = parseInt(clickedItem.dataset.pokemonNumber);
        const pokemon = allPokemons.find(p => p.number === pokemonNumber);
        if (pokemon) {
            showPokemonDetail(pokemon);
        }
    }
});

// Modal Elements
const pokemonDetailModal = document.getElementById('pokemonDetailModal');
const closeModalButton = document.getElementById('closeModalButton');
const modalPokemonName = document.getElementById('modalPokemonName');
const modalPokemonNumber = document.getElementById('modalPokemonNumber');
const modalPokemonTypes = document.getElementById('modalPokemonTypes');
const modalPokemonPhoto = document.getElementById('modalPokemonPhoto');
const pokemonDetailContent = document.getElementById('pokemonDetailContent'); // Get the modal content div

function showPokemonDetail(pokemon) {
    modalPokemonName.textContent = pokemon.name;
    modalPokemonNumber.textContent = `#${pokemon.number.toString().padStart(3, '0')}`;
    modalPokemonPhoto.src = pokemon.photo;
    modalPokemonPhoto.alt = pokemon.name;

    // Clear previous types and add new ones
    modalPokemonTypes.innerHTML = pokemon.types.map((type) => `<li class="type ${type}">${type}</li>`).join('');

    // Remove previous type classes and add the current one for thematic styling
    pokemonDetailContent.className = 'modal-content'; // Reset classes
    pokemonDetailContent.classList.add(pokemon.type);

    pokemonDetailModal.style.display = 'flex'; // Show the modal
}

closeModalButton.addEventListener('click', () => {
    pokemonDetailModal.style.display = 'none'; // Hide the modal
});

// Close modal when clicking outside of the modal content
pokemonDetailModal.addEventListener('click', (event) => {
    if (event.target === pokemonDetailModal) {
        pokemonDetailModal.style.display = 'none';
    }
});
loadMoreButton.addEventListener('click', () => {
    offset += limit
    const qtdRecordsWithNexPage = offset + limit

    if (qtdRecordsWithNexPage >= maxRecords) {
        const newLimit = maxRecords - offset
        loadPokemonItens(offset, newLimit)

        loadMoreButton.parentElement.removeChild(loadMoreButton)
    } else {
        loadPokemonItens(offset, limit)
    }
})
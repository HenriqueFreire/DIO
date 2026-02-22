const whiteKeys = document.querySelectorAll('.white-key');
const blackKeys = document.querySelectorAll('.black-key');

const playNote = (key) => {
    const noteId = key.id; // e.g., "noteA"
    const audio = new Audio(`./sounds/${noteId}.mp3`); // Assuming audio files are in a 'sounds' folder
    audio.play();

    key.classList.add('active');
    audio.addEventListener('ended', () => {
        key.classList.remove('active');
    });
};

// Event listeners for mouse clicks
whiteKeys.forEach(key => {
    key.addEventListener('click', () => playNote(key));
});

blackKeys.forEach(key => {
    key.addEventListener('click', () => playNote(key));
});

// Event listeners for keyboard presses
document.addEventListener('keydown', (e) => {
    const keyPressed = e.key.toLowerCase();
    const whiteKey = document.querySelector(`.white-key[data-key="${keyPressed}"]`);
    const blackKey = document.querySelector(`.black-key[data-key="${keyPressed}"]`);

    if (whiteKey) {
        playNote(whiteKey);
    } else if (blackKey) {
        playNote(blackKey);
    }
});

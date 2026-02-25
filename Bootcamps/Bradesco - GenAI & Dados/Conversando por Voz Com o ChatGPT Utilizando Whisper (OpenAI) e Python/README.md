# LingoLocal - English Practice App

LingoLocal is a mobile application for practicing English conversation with a local AI assistant. It provides real-time grammar correction, audio transcription, and narration, all running locally.

## Features

- **Local AI Processing**: Uses LanguageTool for Portuguese grammar/spelling corrections and Whisper for audio transcription.
- **Voice Chat**: Record your voice and receive instant transcriptions and corrections.
- **Narrations**: Listen to the correct pronunciation of messages.
- **Privacy First**: Everything runs on your machine. No cloud processed data.

## Project Structure

- `backend/`: Python FastAPI server with IA integrations (Whisper, LanguageTool, SQLAlchemy).
- `frontend/`: React Native mobile application.
- `shell.nix`: Reproducible development environment with Nix.

## Getting Started

### Prerequisites

- [Nix](https://nixos.org/download.html) (Mandatory for the orchestrated environment)
- Docker (Optional, for future containerized deployment)

### Running the Backend

1. Enter the nix environment:
   ```bash
   nix-shell shell.nix
   ```
2. Navigate to the backend and start the server:
   ```bash
   # From root
   PYTHONPATH=backend uvicorn app.main:app --host 0.0.0.0 --reload
   ```
   *Note: The first run will download AI models and initialize the Java server for LanguageTool.*

### Running the Frontend

1. Ensure you are in the `nix-shell`.
2. Navigate to the frontend folder:
   ```bash
   cd frontend
   ```
3. Install dependencies:
   ```bash
   npm install
   ```
4. Start the Metro Bundler:
   ```bash
   npx react-native start
   ```
5. Run on Android or iOS:
   ```bash
   npx react-native run-android # or run-ios
   ```

## Development

- **TDD**: Tests are located in `backend/tests/`. Run them with `pytest` inside `nix-shell`.
- **Database**: Uses SQLite (`sql_app.db`) for lightweight local storage.
- **Audio**: Static files are stored in `backend/static/audio`.

## License

Personal use or Open Source.

package com.example.copa_2026.ui.matches

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.copa_2026.data.model.Match
import com.example.copa_2026.data.remote.ApiService
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

sealed interface MatchesUiState {
    data class Success(val matches: List<Match>) : MatchesUiState
    data class Error(val message: String) : MatchesUiState
    object Loading : MatchesUiState
}

class MatchesViewModel : ViewModel() {

    private val _uiState = MutableStateFlow<MatchesUiState>(MatchesUiState.Loading)
    val uiState: StateFlow<MatchesUiState> = _uiState

    init {
        fetchMatches()
    }

    private fun fetchMatches() {
        viewModelScope.launch {
            _uiState.value = MatchesUiState.Loading
            try {
                val response = ApiService.getMatches()
                _uiState.value = MatchesUiState.Success(response.events)
            } catch (e: Exception) {
                _uiState.value = MatchesUiState.Error(e.message ?: "Unknown error")
            }
        }
    }
}

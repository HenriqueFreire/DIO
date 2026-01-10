package com.example.primeiro_app_dio.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.primeiro_app_dio.data.model.Repo
import com.example.primeiro_app_dio.data.repository.AppRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class MainViewModel(private val repository: AppRepository) : ViewModel() {

    private val _uiState = MutableStateFlow(UiState())
    val uiState: StateFlow<UiState> = _uiState.asStateFlow()

    init {
        // Load the last searched username on init
        val initialUsername = repository.getUsername()
        if (initialUsername != null) {
            _uiState.update { it.copy(username = initialUsername) }
            // Optionally, you could also fetch the repos for this user automatically
            // fetchRepos(initialUsername)
        }
    }

    fun fetchRepos(username: String) {
        viewModelScope.launch {
            repository.listRepos(username)
                .onStart {
                    _uiState.update { it.copy(isLoading = true, error = null) }
                }
                .catch { error ->
                    _uiState.update { it.copy(isLoading = false, error = error.message) }
                }
                .collect { repos ->
                    _uiState.update {
                        it.copy(isLoading = false, repos = repos)
                    }
                    // Save username only on successful fetch
                    repository.saveUsername(username)
                }
        }
    }

    fun onUsernameChange(username: String) {
        _uiState.update { it.copy(username = username) }
    }

    data class UiState(
        val username: String = "",
        val repos: List<Repo> = emptyList(),
        val isLoading: Boolean = false,
        val error: String? = null
    )
}

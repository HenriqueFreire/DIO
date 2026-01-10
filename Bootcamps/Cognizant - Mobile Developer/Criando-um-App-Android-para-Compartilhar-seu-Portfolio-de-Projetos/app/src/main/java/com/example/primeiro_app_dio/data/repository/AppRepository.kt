package com.example.primeiro_app_dio.data.repository

import com.example.primeiro_app_dio.data.model.Repo
import com.example.primeiro_app_dio.data.remote.GitHubService
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class AppRepository(
    private val service: GitHubService,
    private val prefs: AppPreferences
) {

    suspend fun listRepos(user: String): Flow<List<Repo>> {
        return flow {
            val repos = service.listRepos(user)
            emit(repos)
        }
    }

    fun saveUsername(username: String) {
        prefs.saveUsername(username)
    }

    fun getUsername(): String? {
        return prefs.getUsername()
    }
}

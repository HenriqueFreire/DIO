package com.example.primeiro_app_dio.ui

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.primeiro_app_dio.data.remote.GitHubService
import com.example.primeiro_app_dio.data.repository.AppPreferences
import com.example.primeiro_app_dio.data.repository.AppRepository

class ViewModelFactory(private val context: Context) : ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(MainViewModel::class.java)) {
            val repository = AppRepository(
                service = GitHubService.create(),
                prefs = AppPreferences(context.applicationContext)
            )
            @Suppress("UNCHECKED_CAST")
            return MainViewModel(repository) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }

    companion object {
        fun create(context: Context): ViewModelFactory {
            return ViewModelFactory(context)
        }
    }
}

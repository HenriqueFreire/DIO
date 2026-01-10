package com.example.primeiro_app_dio.data.repository

import android.content.Context
import android.content.SharedPreferences

class AppPreferences(context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences("github_prefs", Context.MODE_PRIVATE)

    fun saveUsername(username: String) {
        prefs.edit().putString(KEY_USERNAME, username).apply()
    }

    fun getUsername(): String? {
        return prefs.getString(KEY_USERNAME, null)
    }

    companion object {
        private const val KEY_USERNAME = "key_username"
    }
}

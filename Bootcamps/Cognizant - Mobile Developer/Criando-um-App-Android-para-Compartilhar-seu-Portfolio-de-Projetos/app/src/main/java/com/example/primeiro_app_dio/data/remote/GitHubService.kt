package com.example.primeiro_app_dio.data.remote

import com.example.primeiro_app_dio.data.model.Repo
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Path

interface GitHubService {

    @GET("users/{user}/repos")
    suspend fun listRepos(@Path("user") user: String): List<Repo>

    companion object {
        private const val BASE_URL = "https://api.github.com/"

        fun create(): GitHubService {
            val retrofit = Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
            return retrofit.create(GitHubService::class.java)
        }
    }
}

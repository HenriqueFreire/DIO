package com.example.copa_2026.data.remote

import com.example.copa_2026.data.model.MatchesResponse
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.engine.cio.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.json.Json

object ApiService {

    private val client = HttpClient(CIO) {
        install(ContentNegotiation) {
            json(Json {
                ignoreUnknownKeys = true
            })
        }
    }

    private const val API_URL = "https://www.thesportsdb.com/api/v1/json/123/eventsnextleague.php?id=4429"

    suspend fun getMatches(): MatchesResponse {
        return client.get(API_URL).body()
    }
}

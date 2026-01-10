package com.example.copa_2026.data.model

import kotlinx.serialization.Serializable

@Serializable
data class MatchesResponse(
    val events: List<Match>
)

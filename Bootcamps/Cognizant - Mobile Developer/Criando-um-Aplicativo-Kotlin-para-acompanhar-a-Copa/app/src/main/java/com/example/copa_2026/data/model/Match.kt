package com.example.copa_2026.data.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Match(
    @SerialName("idEvent")
    val id: String,
    @SerialName("strEvent")
    val name: String,
    @SerialName("strHomeTeam")
    val homeTeam: String,
    @SerialName("strAwayTeam")
    val awayTeam: String,
    @SerialName("dateEventLocal")
    val date: String,
    @SerialName("strTimeLocal")
    val time: String,
    @SerialName("strVenue")
    val venue: String,
    @SerialName("strStatus")
    val status: String,
    @SerialName("strHomeTeamBadge")
    val homeTeamBadgeUrl: String? = null,
    @SerialName("strAwayTeamBadge")
    val awayTeamBadgeUrl: String? = null
)

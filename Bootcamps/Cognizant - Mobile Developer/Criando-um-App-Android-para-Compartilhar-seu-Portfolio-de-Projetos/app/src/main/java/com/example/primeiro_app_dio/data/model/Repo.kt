package com.example.primeiro_app_dio.data.model

import com.google.gson.annotations.SerializedName

data class Repo(
    val id: Long,
    val name: String,
    @SerializedName("html_url")
    val htmlUrl: String,
    val description: String?
)

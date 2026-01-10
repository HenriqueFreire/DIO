package com.example.copa_2026

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import coil.request.ImageRequest
import com.example.copa_2026.data.model.Match
import com.example.copa_2026.ui.matches.MatchesUiState
import com.example.copa_2026.ui.matches.MatchesViewModel
import com.example.copa_2026.ui.theme.Copa2026Theme

class MainActivity : ComponentActivity() {
    private val viewModel: MatchesViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Copa2026Theme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val uiState by viewModel.uiState.collectAsState()
                    MatchesScreen(uiState = uiState)
                }
            }
        }
    }
}

@Composable
fun MatchesScreen(uiState: MatchesUiState) {
    when (uiState) {
        is MatchesUiState.Loading -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                CircularProgressIndicator()
            }
        }
        is MatchesUiState.Success -> {
            LazyColumn(
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                items(uiState.matches) { match ->
                    MatchItem(match = match)
                }
            }
        }
        is MatchesUiState.Error -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                Text(text = uiState.message, textAlign = TextAlign.Center)
            }
        }
    }
}

@Composable
fun MatchItem(match: Match, modifier: Modifier = Modifier) {
    Card(modifier = modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly,
                verticalAlignment = Alignment.CenterVertically
            ) {
                TeamInfo(teamName = match.homeTeam, teamBadgeUrl = match.homeTeamBadgeUrl)
                Text(text = "vs", style = MaterialTheme.typography.headlineSmall)
                TeamInfo(teamName = match.awayTeam, teamBadgeUrl = match.awayTeamBadgeUrl)
            }
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                text = "${match.date} - ${match.time}",
                style = MaterialTheme.typography.bodyMedium,
                modifier = Modifier.align(Alignment.CenterHorizontally)
            )
            Text(
                text = match.venue,
                style = MaterialTheme.typography.bodySmall,
                modifier = Modifier.align(Alignment.CenterHorizontally)
            )
        }
    }
}

@Composable
fun TeamInfo(teamName: String, teamBadgeUrl: String?, modifier: Modifier = Modifier) {
    Column(
        modifier = modifier,
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        AsyncImage(
            model = ImageRequest.Builder(LocalContext.current)
                .data(teamBadgeUrl)
                .crossfade(true)
                .build(),
            contentDescription = "$teamName badge",
            contentScale = ContentScale.Crop,
            modifier = Modifier.size(64.dp)
        )
        Text(text = teamName, style = MaterialTheme.typography.titleMedium, textAlign = TextAlign.Center)
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    Copa2026Theme {
        val mockMatch = Match("1", "Brazil vs Argentina", "Brazil", "Argentina", "2026-07-19", "20:00", "MetLife Stadium", "Not Started", "", "")
        MatchesScreen(uiState = MatchesUiState.Success(listOf(mockMatch)))
    }
}

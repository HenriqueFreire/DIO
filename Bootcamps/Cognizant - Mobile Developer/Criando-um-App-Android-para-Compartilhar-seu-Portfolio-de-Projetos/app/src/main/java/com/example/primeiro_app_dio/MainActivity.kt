package com.example.primeiro_app_dio

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import com.example.primeiro_app_dio.ui.MainScreen
import com.example.primeiro_app_dio.ui.MainViewModel
import com.example.primeiro_app_dio.ui.ViewModelFactory
import com.example.primeiro_app_dio.ui.theme.Primeiro_App_DIOTheme

class MainActivity : ComponentActivity() {

    private val viewModel: MainViewModel by viewModels {
        ViewModelFactory.create(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Primeiro_App_DIOTheme {
                MainScreen(viewModel = viewModel)
            }
        }
    }
}

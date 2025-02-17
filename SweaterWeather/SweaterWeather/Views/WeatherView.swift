//
//  WeatherView.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 2/16/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching Weather...")
            } else if let weather = viewModel.weather {
                VStack {
                    Text("Location: \(weather.lat)")
                        .font(.title)
                    Text("Temp: \(weather.current.temp, specifier: "%.1f")°F")
                        .font(.largeTitle)
                    Text("Feels Like: \(weather.current.feelsLike, specifier: "%.1f")°F")
                        .font(.largeTitle)
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Fetch Weather") {
                viewModel.getWeather(lat: 43.05451892010724, lon: -89.39929205999775) // Example: San Francisco
            }
            .padding()
        }
    }
}

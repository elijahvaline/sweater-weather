//
//  WeatherViewModel.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 2/15/25.
//


import SwiftUI

class WeatherViewModel: ObservableObject {
    @ObservedObject var settings = Settings.sharedSettings
    
    @Published var weather: WeatherModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var sweaterFactor: Int = 0
    @Published var sweaterThreshold: Int = 0
    @Published var sweaterDifferential: Int = 0
    @Published var sweaterRecommendation: String = "Loading..."
    

    private let weatherService = WeatherService()

    func getWeather(lat: Double, lon: Double) {
        isLoading = true
        errorMessage = nil

        weatherService.fetchWeather(lat: lat, lon: lon) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let weatherData):
                    self.weather = weatherData
                    self.calculateSweaterFactor()
                    self.setSweaterRecommendation()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func calculateSweaterFactor() {
        sweaterFactor = SweaterFunctions.sweaterFactor(currentWeather: weather!)
        sweaterThreshold = settings.sweaterThreshhold
        sweaterDifferential = sweaterThreshold - sweaterFactor
    }
    
    func setSweaterRecommendation() {
        if (sweaterFactor <= sweaterThreshold){
            sweaterRecommendation = "Wear a sweater."
        }
        else{
            sweaterRecommendation = "Don't wear a sweater."
        }
    }
}

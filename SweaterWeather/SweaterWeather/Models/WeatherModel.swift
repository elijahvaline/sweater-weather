import Foundation

//
//  WeatherModel.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 2/15/25.
//

struct CurrentWeatherInstance: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure : Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
    }
}

struct HourWeatherInstance: Codable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure : Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let windSpeed: Double
    let windGust: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, temp, pressure, humidity, uvi, clouds
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
    }
}

struct WeatherModel: Codable {
    let lat: Double
    let lon: Double
    let current : CurrentWeatherInstance
    let hourly: [HourWeatherInstance]
}


//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by rentamac on 1/26/26.
//
import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {

    // UI State
    @Published var temperature: Double?
    @Published var relativeHumidity: Int?
    @Published var windSpeed: Double?
    @Published var visibility: Double?
    @Published var showers: Double?
    @Published var weatherIcon: String = "questionmark"

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    // Load from SAME object
    func loadCachedWeather(from location: WeatherLocation) {
        temperature = location.temperature
        relativeHumidity = Int(location.relativeHumidity)
        windSpeed = location.windSpeed
        visibility = location.visibility
        showers = location.showers
        weatherIcon = location.weatherIcon ?? "questionmark"
    }

    // Fetch + update SAME object
    func fetchWeather(for location: WeatherLocation) async {

        if location.temperature > 0,
           let updatedAt = location.updatedAt,
           Date().timeIntervalSince(updatedAt) < 60 {

            loadCachedWeather(from: location)
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )

            let icon = WeatherIconMapper.icon(
                for: response.current.weatherCode
            )

            // 🔥 UPDATE SAME CORE DATA OBJECT
            location.temperature = response.current.temperature2M
            location.relativeHumidity = Int16(response.current.relativeHumidity)
            location.windSpeed = response.current.windSpeed
            location.visibility = response.current.visibility
            location.showers = response.current.showers
            location.weatherIcon = icon
            location.updatedAt = Date()

            PersistenceController.shared.save()

            // Update UI
            loadCachedWeather(from: location)

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

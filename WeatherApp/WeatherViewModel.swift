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

    // MARK: - UI State
    @Published var temperature: Double?
    @Published var relativeHumidity: Int?
    @Published var windSpeed: Double?
    @Published var visibility: Double?
    @Published var showers: Double?

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    // MARK: - Init
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    // MARK: - Load cached data (used immediately on screen load)
    func loadCachedWeather(
        name: String,
        latitude: Double,
        longitude: Double
    ) {
        if let cached = PersistenceController.shared.fetchLocation(
            name: name,
            latitude: latitude,
            longitude: longitude
        ) {
            temperature = cached.temperature
            relativeHumidity = Int(cached.relativeHumidity)
            windSpeed = cached.windSpeed
            visibility = cached.visibility
            showers = cached.showers
        }
    }

    // MARK: - Fetch weather (with 1-minute cache validation)
    func fetchWeather(
        name: String,
        latitude: Double,
        longitude: Double
    ) async {

        // 1️⃣ Check cache freshness
        if let cached = PersistenceController.shared.fetchLocation(
            name: name,
            latitude: latitude,
            longitude: longitude
        ),
        let lastUpdated = cached.updatedAt,
        !shouldRefetchWeather(lastUpdated: lastUpdated) {

            temperature = cached.temperature
            relativeHumidity = Int(cached.relativeHumidity)
            windSpeed = cached.windSpeed
            visibility = cached.visibility
            showers = cached.showers
            return
        }

        // 2️⃣ Fetch from API
        isLoading = true
        errorMessage = nil

        do {
            let response = try await weatherService.fetchWeather(
                latitude: latitude,
                longitude: longitude
            )

            // 3️⃣ Map API → UI
            temperature = response.current.temperature2M
            relativeHumidity = response.current.relativeHumidity
            windSpeed = response.current.windSpeed
            visibility = response.current.visibility
            showers = response.current.showers

            // 4️⃣ Map weather code → icon
            let apiIcon = WeatherIconMapper.icon(
                for: response.current.weatherCode
            )

            // 5️⃣ Save everything to Core Data
            if let temperature {
                PersistenceController.shared.upsertLocation(
                    name: name,
                    latitude: latitude,
                    longitude: longitude,
                    weatherIcon: apiIcon,
                    temperature: temperature,
                    relativeHumidity: relativeHumidity,
                    windSpeed: windSpeed,
                    visibility: visibility,
                    showers: showers
                )
            }

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Cache validation (1 minute rule)
    private func shouldRefetchWeather(lastUpdated: Date) -> Bool {
        Date().timeIntervalSince(lastUpdated) >= 60
    }
}

//
//  WeatherService.swift
//  WeatherApp
//
//  Created by rentamac on 1/26/26.
//
import Foundation

protocol WeatherServiceProtocol {
func fetchWeather(
latitude: Double,
longitude: Double
) async throws -> WeatherResponse
}

final class WeatherService: WeatherServiceProtocol {

private let networkService: Networking

init(networkService: Networking) {
self.networkService = networkService
}

func fetchWeather(
latitude: Double,
longitude: Double
) async throws -> WeatherResponse {

let request = WeatherRequest(
latitude: latitude,
longitude: longitude
)

let endpoint = WeatherEndpoint(
request: request
)

return try await networkService.request(
endpoint: endpoint,
responseType: WeatherResponse.self
)
}
}

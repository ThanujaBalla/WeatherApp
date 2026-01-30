//
//  GeocodingResponse.swift
//  WeatherApp
//
//  Created by rentamac on 1/29/26.
//
import Foundation
import Combine

struct GeocodingResponse: Decodable {
    let results: [GeocodingLocation]?
}

struct GeocodingLocation: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String?
    let admin1: String?
}

struct GeocodingEndpoint: APIEndpoint{
    let query: String
    var baseURL: String {"https://geocoding-api.open-meteo.com"}
    var path: String {"/v1/search"}
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "name", value: query),
        URLQueryItem(name: "count", value: "5")]
    }
}

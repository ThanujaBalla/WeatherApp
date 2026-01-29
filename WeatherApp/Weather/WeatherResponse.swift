//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by rentamac on 1/26/26.
//
import Foundation

struct WeatherResponse: Codable {
let latitude, longitude, generationtimeMS: Double
let utcOffsetSeconds: Int
let timezone, timezoneAbbreviation: String
let elevation: Int
let currentUnits: CurrentUnits
let current: Current

enum CodingKeys: String, CodingKey {
case latitude, longitude
case generationtimeMS = "generationtime_ms"
case utcOffsetSeconds = "utc_offset_seconds"
case timezone
case timezoneAbbreviation = "timezone_abbreviation"
case elevation
case currentUnits = "current_units"
case current
}
}

// MARK: - Current
struct Current: Codable {
let time: String
let interval: Int
let temperature2M: Double
    let visibility: Double
    let windSpeed: Double
    let showers: Double
    let relativeHumidity: Int
    let weatherCode: Int

enum CodingKeys: String, CodingKey {
case time, interval
case temperature2M = "temperature_2m"
    case visibility = "visibility"
    case windSpeed = "windspeed_10m"
    case showers = "showers"
    case relativeHumidity = "relative_humidity_2m"
    case weatherCode = "weathercode"
    
}
}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
let time, interval, temperature2M: String
    let visibility:String
    let windSpeed: String
    let showers: String
    let relativeHumidity: String

enum CodingKeys: String, CodingKey {
case time, interval
case temperature2M = "temperature_2m"
    case visibility = "visibility"
    case windSpeed = "windspeed_10m"
    case showers = "showers"
    case relativeHumidity = "relative_humidity_2m"
}
}


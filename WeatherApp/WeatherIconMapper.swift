//
//  WeatherIconMapper.swift
//  WeatherApp
//
//  Created by rentamac on 1/28/26.
//
struct WeatherIconMapper {

    static func icon(for code: Int) -> String {
        switch code {
        case 0:
            return "sun.max.fill"
        case 1, 2, 3:
            return "cloud.sun.fill"
        case 45, 48:
            return "cloud.fog.fill"            
        case 51, 53, 55:
            return "cloud.drizzle.fill"
        case 61, 63, 65:
            return "cloud.rain.fill"
        case 71, 73, 75:
            return "cloud.snow.fill"
        case 95:
            return "cloud.bolt.rain.fill"
        default:
            return "cloud.fill"
        }
    }
}


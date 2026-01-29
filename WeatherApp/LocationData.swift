//
//  LocationData.swift
//  WeatherApp
//
//  Created by rentamac on 1/22/26.
//
import Foundation

enum Weather {
case sunny
case foggy
case snow
case rainy
case windy

var icon: String {
switch self {
case .sunny:
return "sun.max.fill"
case .foggy:
return "cloud.fog.fill"
case .snow:
return "snowflake"
case .rainy:
return "cloud.rain.fill"
case .windy:
return "wind"
}
}
}

struct SeedLocation {
    let name: String
    let latitude: Double
    let longitude: Double
    
}


struct Temperature {
let min: Int
let max: Int

var temperatureText: String {
"\(min) °C / \(max) °C"
}
}


let seedLocations: [SeedLocation] = [
    SeedLocation(name: "Mumbai", latitude: 19.0760, longitude: 72.8777),
    SeedLocation(name: "Delhi", latitude: 28.6139, longitude: 77.2090),
    SeedLocation(name: "Pune", latitude: 18.5204, longitude: 73.8567),
    SeedLocation(name: "Bangalore", latitude: 12.9716, longitude: 77.5946),
    SeedLocation(name: "Chennai", latitude: 13.0827, longitude: 80.2707),
    SeedLocation(name: "Hyderabad", latitude: 17.3850, longitude: 78.4867),
    SeedLocation(name: "Kolkata", latitude: 22.5726, longitude: 88.3639),
    SeedLocation(name: "Ahmedabad", latitude: 23.0255, longitude: 72.5714,),
    SeedLocation(name: "Jaipur", latitude: 26.9124, longitude: 75.7873),
    SeedLocation(name: "Surat", latitude: 21.1702, longitude: 72.8311),
    SeedLocation(name: "Guwahati", latitude: 26.1445, longitude: 91.7362),
    SeedLocation(name: "Indore", latitude: 22.7196, longitude: 75.8577),
    SeedLocation(name: "Visakhapatnam", latitude: 17.6868, longitude: 83.2185),
    SeedLocation(name: "Nagpur", latitude: 21.1458, longitude: 79.0882),
    SeedLocation(name: "Bhopal", latitude: 23.2599, longitude: 77.4126),
    SeedLocation(name: "Kochi", latitude: 9.9312, longitude: 76.2673),
    SeedLocation(name: "Udaipur", latitude: 24.5854, longitude: 73.7125),
    SeedLocation(name: "Gangtok", latitude: 27.3314, longitude: 88.6138)
]

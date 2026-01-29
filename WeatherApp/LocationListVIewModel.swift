//
//  LocationListVIewModel.swift
//  WeatherApp
//
//  Created by rentamac on 1/28/26.
//
import Foundation
import Combine

@MainActor
final class LocationListViewModel: ObservableObject {

    @Published var cachedLocations: [WeatherLocation] = []

    func loadCachedLocations(searchText: String = "") {
           let all = PersistenceController.shared.fetchAllLocations()

           if searchText.isEmpty {
               cachedLocations = all
           } else {
               cachedLocations = all.filter {
                   ($0.name ?? "")
                       .localizedCaseInsensitiveContains(searchText)
               }
           }
       }

    func temperatureFor(
        name: String,
        latitude: Double,
        longitude: Double
    ) -> Double? {
        cachedLocations.first {
            $0.name == name &&
            $0.latitude == latitude &&
            $0.longitude == longitude
        }?.temperature
    }
    
    func lastUpdatedText(
        name: String,
        latitude: Double,
        longitude: Double
    ) -> String? {

        guard let location = cachedLocations.first(where: {
            $0.name == name &&
            $0.latitude == latitude &&
            $0.longitude == longitude
        }),
        let updatedAt = location.updatedAt
        else {
            return nil
        }

        let seconds = Int(Date().timeIntervalSince(updatedAt))

        if seconds < 60 {
            return "Updated \(seconds)s ago"
        } else {
            return "Updated \(seconds / 60)m ago"
        }
    }

}



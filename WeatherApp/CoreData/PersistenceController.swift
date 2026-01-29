//
//  PersistenceController.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//
import Foundation
import CoreData

final class PersistenceController {

    static let shared = PersistenceController()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data error \(error)")
            }
        }
    }

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }

    func upsertLocation(
        name: String,
        latitude: Double,
        longitude: Double,
        weatherIcon: String,
        temperature: Double,
        relativeHumidity: Int?,
        windSpeed: Double?,
        visibility: Double?,
        showers: Double?
    ) {
        let context = container.viewContext

        let location =
            fetchLocation(name: name, latitude: latitude, longitude: longitude)
            ?? WeatherLocation(context: context)

        location.id = location.id ?? UUID()
        location.name = name
        location.latitude = latitude
        location.longitude = longitude
        if location.weatherIcon == nil || location.weatherIcon?.isEmpty == true {
            location.weatherIcon = weatherIcon
        }

        location.temperature = temperature
        location.relativeHumidity = Int16(relativeHumidity ?? 0)
        location.windSpeed = windSpeed ?? 0
        location.visibility = visibility ?? 0
        location.showers = showers ?? 0
        location.updatedAt = Date()

        save()
    }



    func fetchLocation(
        name: String,
        latitude: Double,
        longitude: Double
    ) -> WeatherLocation? {

        let request: NSFetchRequest<WeatherLocation> =
            WeatherLocation.fetchRequest()

        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "name == %@ AND latitude == %lf AND longitude == %lf",
            name, latitude, longitude
        )

        return try? container.viewContext.fetch(request).first
    }

    func fetchAllLocations() -> [WeatherLocation] {
        let request: NSFetchRequest<WeatherLocation> =
            WeatherLocation.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(key: "updatedAt", ascending: false)
        ]

        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    
    func seedLocationsIfNeeded(_ seeds: [SeedLocation]) {
        let existing = fetchAllLocations()

        // ❗ IMPORTANT: only skip if counts match
        guard existing.count < seeds.count else { return }

        let context = container.viewContext

        for seed in seeds {
            let exists = existing.contains {
                $0.name == seed.name &&
                $0.latitude == seed.latitude &&
                $0.longitude == seed.longitude
            }

            if !exists {
                let location = WeatherLocation(context: context)
                location.id = UUID()
                location.name = seed.name
                location.latitude = seed.latitude
                location.longitude = seed.longitude
                
            }
        }

        save()
    }


}



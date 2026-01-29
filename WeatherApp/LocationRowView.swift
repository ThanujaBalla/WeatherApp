//
//  LocationRowView.swift
//  WeatherApp
//
//  Created by rentamac on 1/28/26.
//
import SwiftUI

struct LocationRowView: View {

    let location: WeatherLocation
    let viewModel: LocationListViewModel

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: location.weatherIcon ?? "questionmark")
                .foregroundColor(.yellow)
                .font(.title2)

            Spacer()

            VStack(alignment: .leading, spacing: 4) {
                Text(location.name ?? "")
                    .foregroundColor(.white)
                    .font(.headline)

                if let temp = viewModel.temperatureFor(
                    name: location.name ?? "",
                    latitude: location.latitude,
                    longitude: location.longitude
                ) {
                    Text("\(temp, specifier: "%.1f") °C")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }

                if let updatedText = viewModel.lastUpdatedText(
                    name: location.name ?? "",
                    latitude: location.latitude,
                    longitude: location.longitude
                ) {
                    Text(updatedText)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.05))
        )
    }
}


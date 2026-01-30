//
//  LocationDetailView.swift
//  WeatherApp
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI

struct LocationDetailView: View {

    @ObservedObject var location: WeatherLocation
    @StateObject private var viewModel =
        WeatherViewModel(
            weatherService: WeatherService(
                networkService: HttpNetworking()
            )
        )

    private func InfoCard(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
        )
    }

    var body: some View {
        ZStack {
            Color("Color").ignoresSafeArea()

            VStack(spacing: 24) {

                Text(location.name ?? "")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Image(systemName: viewModel.weatherIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .foregroundColor(.yellow)

                if let temp = viewModel.temperature {
                    Text("\(temp, specifier: "%.1f") °C")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                } else if viewModel.isLoading {
                    Text("Loading…")
                        .foregroundColor(.white.opacity(0.7))
                }

                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        InfoCard(
                            title: "Humidity",
                            value: "\(viewModel.relativeHumidity ?? 0)%"
                        )
                        InfoCard(
                            title: "Wind",
                            value: "\(viewModel.windSpeed ?? 0) km/h"
                        )
                    }
                    HStack(spacing: 12) {
                        InfoCard(
                            title: "Showers",
                            value: "\(viewModel.showers ?? 0)"
                        )
                        InfoCard(
                            title: "Visibility",
                            value: "\(viewModel.visibility ?? 0) km"
                        )
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 20)
        }
        .task {
            viewModel.loadCachedWeather(from: location)
            await viewModel.fetchWeather(for: location)
        }
    }
}

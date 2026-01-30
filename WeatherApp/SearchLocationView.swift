//
//  SearchLocationView.swift
//  WeatherApp
//
//  Created by rentamac on 1/30/26.
//

import SwiftUI
import MapKit

struct SearchLocationRow: View {

    let location: GeocodingLocation

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // Location title
            Text("\(location.name), \(location.admin1 ?? ""), \(location.country ?? "")")
                .font(.headline)
                .foregroundColor(.white)

            // Map preview
            Map(
                coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.6,
                            longitudeDelta: 0.6
                        )
                    )
                )
            )
            .frame(height: 140)
            .cornerRadius(12)
            .allowsHitTesting(false)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
}


struct SearchLocationView: View {

    @StateObject private var viewModel = LocationSearchViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color("Color")
                .ignoresSafeArea()

            List {
                ForEach(viewModel.results) { location in
                    SearchLocationRow(location: location)
                        .onTapGesture {
                            PersistenceController.shared.upsertLocation(
                                name: location.name,
                                latitude: location.latitude,
                                longitude: location.longitude,
                                weatherIcon: "questionmark",
                                temperature: 0,
                                relativeHumidity: 0,
                                windSpeed: 0,
                                visibility: 0,
                                showers: 0
                            )
                            dismiss()
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 6)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Add Location")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search city"
        )
        .onChange(of: viewModel.searchText) {
            Task { await viewModel.search() }
        }
    }
}

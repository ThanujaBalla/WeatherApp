//
//  LocationSearchViewModel.swift
//  WeatherApp
//
//  Created by rentamac on 1/29/26.
//
import Foundation
import Combine

@MainActor
final class LocationSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [GeocodingLocation] = []
    @Published var isLoading = false

    private let networking: Networking

    init(networking: Networking = HttpNetworking()) {
        self.networking = networking
    }

    func search() async {
        guard !searchText.isEmpty else {
            results = []
            return
        }

        isLoading = true
        do {
            let response: GeocodingResponse = try await networking.request(
                endpoint: GeocodingEndpoint(query: searchText),
                responseType: GeocodingResponse.self
            )
            results = response.results ?? []
        } catch {
            results = []
        }
        isLoading = false
    }
}

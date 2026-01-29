//
//  ContentView.swift
//  WeatherApp
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            LandingView()
        }.task{
            PersistenceController.shared.seedLocationsIfNeeded(seedLocations)
        }
    }
}

#Preview {
    ContentView()
}

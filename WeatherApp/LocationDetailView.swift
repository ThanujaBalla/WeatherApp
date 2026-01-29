//
//  LocationDetailView.swift
//  WeatherApp
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI
struct LocationDetailView: View {
    let location : WeatherLocation
    @StateObject private var viewModel = WeatherViewModel(weatherService: WeatherService(networkService: HttpNetworking()))
    
    
    private func Infocard(title: String, value:String )-> some View{
        VStack(spacing: 6){
            Text(title).font(.caption).foregroundColor(.white.opacity(0.6))
            Text(value).font(.headline).foregroundColor(.white)
        }.frame(maxWidth: .infinity).padding().background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.08)))
    }
    
    var body: some View {
        ZStack {
                    Color("Color")
                        .ignoresSafeArea()

                    VStack(spacing: 24) {
                        Text(location.name ?? "")
                            .font(.largeTitle)
                            .foregroundColor(.white)

                        Image(systemName: location.weatherIcon ?? "questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .foregroundColor(.yellow)
                        if let temperature = viewModel.temperature {
                            Text("\(temperature, specifier: "%.1f") °C").font(Font.largeTitle.bold()).foregroundColor(Color.white)
                        }else if viewModel.isLoading {
                            Text("Loading...")
                                .foregroundColor(.white.opacity(0.7))
                        }else if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(Color.red)
                        }

                        VStack(spacing: 12){
                            HStack(spacing: 12){
                                Infocard(title: "Humidity", value: "\(viewModel.relativeHumidity ?? 32) %")
                                Infocard(title: "Wind Speed", value:"\(viewModel.windSpeed ?? 34.2) km/h")
                            }
                            HStack(spacing: 12){
                                Infocard(title: "Showers", value: "\(viewModel.showers ?? 32.1)")
                                Infocard(title: "Visibility", value: "\(viewModel.visibility ?? 34.1) km")
                            }
                        }.padding(.horizontal,16)

                        Spacer()
                    }
                    .padding(.top, 20)
        }.task{
            let cityName = location.name ?? ""
            viewModel.loadCachedWeather(
                    name: cityName,
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            await viewModel.fetchWeather(name: cityName,latitude: location.latitude, longitude: location.longitude)
        }
    }
}

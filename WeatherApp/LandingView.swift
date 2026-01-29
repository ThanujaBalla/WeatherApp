//
//  LandingView.swift
//  WeatherApp
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack {
            Color("Color").ignoresSafeArea()
            VStack(spacing: 16) {
                Spacer()
                Image("Umbrella")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                Text("Breeze").font(Font.largeTitle.bold())
                    .foregroundColor(Color.white.opacity(0.7))
                Text("Weather App")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
                NavigationLink(destination: LocationListView()) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Circle())
                }.padding(.bottom, 32)
            }
        }
    }
}

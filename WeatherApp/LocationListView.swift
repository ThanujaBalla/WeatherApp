//
//  LocationListView.swift
//  WeatherApp
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI


struct LocationListView: View {
    @State private var searchText: String = ""
    @State private var refreshID = UUID()

    @StateObject private var viewModel = LocationListViewModel()
    var body: some View {
        
        
        List {
            ForEach(viewModel.cachedLocations) { location in
                NavigationLink {                    LocationDetailView(location: location)
                        .onDisappear{

                            refreshID = UUID()
                        }
                } label: {
                    LocationRowView(
                        location: location,
                        viewModel: viewModel
                    )
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                .padding(.vertical, 3)
            }
        }
        .task(id: refreshID){
                viewModel.loadCachedLocations()
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.visible)
            .background(Color("Color"))
            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search location")
                .navigationTitle(Text("Locations"))
                .onChange(of: searchText) { newValue in
                    viewModel.loadCachedLocations(searchText: newValue)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink{
                            SearchLocationView()
                        }label:{
                            Image(systemName: "plus")
                        }
                    }
                }
            
            
        
    
    
    }
    
}

//
//  CityView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

struct CityView: View {
    
    var city: City
    
    @ObservedObject var viewModel: CityViewModel
    @Environment(\.managedObjectContext) var context
    var placeholder: String = "unknown"
    
    
    
    var body: some View {
        GeometryReader { geo in
            
            VStack{
                Image("nunu")
                    
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .opacity(0.5)
                    .overlay(
                        List {
                            if viewModel.dataSource.isEmpty {
                                emptySection
                            } else {
                                cityHourlyWeatherSection
                                forecastSection
                            }
                            
                        }
                        .listStyle(InsetGroupedListStyle())
                    )
                
                
            }
            .navigationBarTitle("\(self.viewModel.city) ⛅️")
            
            .onAppear(perform: {
                viewModel.city = city.city ?? ""
            })
        }
    }
}

private extension CityView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g. Cupertino", text: $viewModel.city)
        }
    }
    
    var forecastSection: some View {
        VStack{
            ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
        }
        
    }
    
    var cityHourlyWeatherSection: some View {
        VStack{
            NavigationLink(destination: viewModel.currentWeatherView) {
                VStack(alignment: .leading) {
                    Text("Weather today")
                        .bold()
                        .font(.system(size: 25))

                        .foregroundColor(.blue)
                }
            }
            Spacer()
        }
        
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}

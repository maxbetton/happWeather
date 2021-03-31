//
//  EditView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

struct EditView: View {
    var city: City

    @ObservedObject var viewModel: CityViewModel
    @Environment(\.managedObjectContext) var context
    var placeholder: String = "unknown"

    

    var body: some View {
        NavigationView {
        
          List {
            
            if viewModel.dataSource.isEmpty {
              emptySection
            } else {
               cityHourlyWeatherSection
              forecastSection
            }
            
          }
          .listStyle(GroupedListStyle())
          .navigationBarTitle("Weather ⛅️")
        }
        .onAppear(perform: {
            viewModel.city = city.city ?? ""
        })
    }
}

private extension EditView {
  var searchField: some View {
    HStack(alignment: .center) {
      TextField("e.g. Cupertino", text: $viewModel.city)
    }
  }

  var forecastSection: some View {
    Section {
      ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
    }
  }

  var cityHourlyWeatherSection: some View {
    Section {
        NavigationLink(destination: viewModel.currentWeatherView) {
        VStack(alignment: .leading) {
          Text(viewModel.city)
          Text("Weather today")
            .font(.caption)
            .foregroundColor(.gray)
        }
      }
    }
  }
    
  var emptySection: some View {
    Section {
      Text("No results")
        .foregroundColor(.gray)
    }
  }
}

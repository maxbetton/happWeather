//
//  ContentView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

    @StateObject var cityVM = CityViewModel()
    
    @ObservedObject var viewModel: WeeklyWeatherViewModel

    init(viewModel: WeeklyWeatherViewModel) {
      self.viewModel = viewModel
    }
    
    //Read data
    @FetchRequest(entity: City.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "cityName", ascending: true)])
    var cities: FetchedResults<City>

    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(cities) { city in
                        NavigationLink(
                            destination: EditView(city: city, cityVM: cityVM),
                            label: {
                                ListCities(city: city)
                            })
                    }
                    .onDelete(perform: { indexSet in
                        self.cityVM.deleteCity(context: context, city: cities[indexSet.first!])
                    })
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing:
            Button(action: { self.cityVM.isAddPresented.toggle() }) {
                Image(systemName: "plus")
                    .font(.title)
            }
            )
            .sheet(isPresented: self.$cityVM.isAddPresented) {
                AddView(cityVM: cityVM)
            }
        }
    }
}
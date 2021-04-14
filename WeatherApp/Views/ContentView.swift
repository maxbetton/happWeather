//
//  ContentView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    
    @StateObject var cityVM: CityViewModel
    
    
    //Read data
    @FetchRequest(entity: City.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "city", ascending: true)])
    var cities: FetchedResults<City>
    
    init(_ cityVM: CityViewModel){
        UITableView.appearance().backgroundColor = .clear
        _cityVM = StateObject(wrappedValue: cityVM)
    }
    
    var body: some View {
        NavigationView {
            
            GeometryReader { geo in
                
                AnimatedImage(url: URL(string:"https://i.pinimg.com/originals/cd/25/45/cd25452763ef54225089858996d1b7ff.gif"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .overlay(
                        List {
                            ForEach(cities) { city in
                                NavigationLink(
                                    destination: CityView(city: city, viewModel: cityVM),
                                    label: {
                                        ListCities(city: city)
                                    })
                            }
                            .onDelete(perform: { indexSet in
                                self.cityVM.deleteCity(context: context, city: cities[indexSet.first!])
                            })
                            
                        }
                        .opacity(0.7)
                        .listStyle(InsetGroupedListStyle())
                        .navigationBarItems(trailing:
                                                Button(action: { self.cityVM.isAddPresented.toggle() }) {
                                                    Image(systemName: "plus")
                                                        .font(.title)
                                                }
                        )
                    )
                    .sheet(isPresented: self.$cityVM.isAddPresented) {
                        AddView(viewModel: cityVM)
                    }
                    .navigationBarTitle("My Cities")
            }
        }
    }
}

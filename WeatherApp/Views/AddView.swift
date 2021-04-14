//
//  AddView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var viewModel: CityViewModel
    
    @FetchRequest(entity: City.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "city", ascending: true)])
    var cities: FetchedResults<City>
    
    
    init(viewModel: CityViewModel) {
        self.viewModel = viewModel
    }
    
    
    
    func verify() -> Bool {
        var result: Bool = false
        for city in cities {
            if viewModel.city == city.city {
                result = false
                break
            } else {
                result = true
            }
        }
        return result
    }
    
    var body: some View {
        GeometryReader { geo in
            
            VStack{
                AnimatedImage(url: URL(string:"https://i.pinimg.com/originals/cd/25/45/cd25452763ef54225089858996d1b7ff.gif"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .overlay(
                        Form {
                            //searchField
                            Section(header: Text("Ville")) {
                                TextField("Paris", text: self.$viewModel.city)
                            }
                            
                            Button(action: {
                                self.viewModel.addCity(context: context)
                            }) {
                                Text("Ajouter la ville")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            
                            if viewModel.dataSource.isEmpty {
                                emptySection
                            } else {
                                cityHourlyWeatherSection
                                forecastSection
                            }
                            
                        })
                    .navigationBarTitle("Ajouter")
            }
        }
        .onAppear(perform: {
            viewModel.city = ""
        })
    }
}

//struct AddView_Previews: PreviewProvider {
//static var previews: some View {
//    AddView()
//  }
//}
//private extension AddView {
//    var searchField: some View {
//      HStack(alignment: .center) {
//        TextField("e.g. Cupertino", text: $viewModel.city)
//      }
//    }
//}

private extension AddView {
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

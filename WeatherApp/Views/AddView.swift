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
            if viewModel.city == city.city || viewModel.dataSource.isEmpty{
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
            NavigationView {
                VStack{
                    List {
                        Section(header: Text("Ville")) {
                            TextField("Paris", text: self.$viewModel.city)
                        }
                        
                        Button(action: {
                            self.viewModel.addCity(context: context)
                        }) {
                            Text("Ajouter la ville")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }.disabled(!self.verify())
                        if viewModel.dataSource.isEmpty {
                            Section {
                                Text("No results")
                                    .foregroundColor(.gray)
                            }
                        } else {
                            VStack{
                                NavigationLink(destination: viewModel.currentWeatherView) {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text("Weather today")
                                            .bold()
                                            .font(.system(size: 25))
                                            .foregroundColor(.blue)
                                    }
                                }
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                ForEach(viewModel.dataSource ) { dailyWeatherVM in
                                    DailyWeatherRowView(viewModel: dailyWeatherVM)
                                }
                            }
                        }
                        
                    }
                    .opacity(0.7)
                    .listStyle(InsetGroupedListStyle())
                    .background(AnimatedImage(url: URL(string:"https://i.pinimg.com/originals/cd/25/45/cd25452763ef54225089858996d1b7ff.gif"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(width: geo.size.width, height: geo.size.height))
                }
                .navigationBarTitle("Ajouter")
            }
            .onAppear(perform: {
                viewModel.city = ""
            })
        }
    }
}

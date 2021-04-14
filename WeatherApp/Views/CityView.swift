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
    @State var image: String = "Clear"
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                List {
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
                        .onAppear{
                            image = viewModel.title
                        }
                    }
                }
                .opacity(0.6)
                .listStyle(InsetGroupedListStyle())
                .background(Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geo.size.width, height: geo.size.height)
                )
                
            }
            .navigationBarTitle("\(self.viewModel.city) ⛅️")
            .onAppear(perform: {
                viewModel.dataSource.removeAll()
                viewModel.city = city.city ?? ""
            })
            .animation(.easeIn)
        }
    }
}

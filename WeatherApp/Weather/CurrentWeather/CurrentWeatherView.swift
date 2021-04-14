//
//  CurrentWeatherView.swift
//  HappyWeather
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel
    @State var image: String = "Clear"
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                List(content: content)
                    .onAppear(perform: viewModel.refresh)
                    .navigationBarTitle(viewModel.city)
                    .listStyle(GroupedListStyle())
                    .background(AnimatedImage(url: URL(string:"https://i.pinimg.com/originals/cd/25/45/cd25452763ef54225089858996d1b7ff.gif"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(width: geo.size.width, height: geo.size.height))
            }
        }
    }
}

private extension CurrentWeatherView {
    func content() -> some View {
        if let viewModel = viewModel.dataSource {
            return AnyView(details(for: viewModel))
        } else {
            return AnyView(loading)
        }
    }
    
    func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
        CurrentWeatherRow(viewModel: viewModel)
        
    }
    
    var loading: some View {
        Text("Loading \(viewModel.city)'s weather...")
            .foregroundColor(.gray)
    }
}

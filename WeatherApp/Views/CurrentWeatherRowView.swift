//
//  CurrentWeatherRow.swift
//  HappyWeather
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

struct CurrentWeatherRowView: View {
    private let viewModel: CurrentWeatherRowViewModel
    
    init(viewModel: CurrentWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            MapView(coordinate: viewModel.coordinate)
                .cornerRadius(25)
                .frame(height: 300)
                .disabled(true)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("☀️ Temperature:")
                        .font(.title)
                    Text("\(viewModel.temperature)°")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                Spacer()
                HStack {
                    Text("📈 Max temperature:")
                        .font(.title)
                    Text("\(viewModel.maxTemperature)°")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                Spacer()
                HStack {
                    Text("📉 Min temperature:")
                        .font(.title)
                    Text("\(viewModel.minTemperature)°")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                Spacer()
                HStack {
                    Text("💧 Humidity:")
                        .font(.title)
                    Text(viewModel.humidity)
                        .foregroundColor(.gray)
                        .font(.title)
                }
            }
        }
    }
}

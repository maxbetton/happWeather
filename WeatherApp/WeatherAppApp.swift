//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        let fetcher = WeatherFetcher()
        let viewModel = WeeklyWeatherViewModel(weatherFetcher: fetcher)
        let weeklyView = WeeklyWeatherView(viewModel: viewModel)
        
        WindowGroup {
            //WeeklyWeatherView(viewModel: viewModel)
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

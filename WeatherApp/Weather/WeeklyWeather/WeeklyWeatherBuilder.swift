//
//  WeeklyWeatherBuilder.swift
//  HappyWeather
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

enum WeeklyWeatherBuilder {
  static func makeCurrentWeatherView(
    withCity city: String,
    weatherFetcher: WeatherFetchable
  ) -> some View {
    let viewModel = CurrentWeatherViewModel(
      city: city,
      weatherFetcher: weatherFetcher)
    return CurrentWeatherView(viewModel: viewModel)
  }
}

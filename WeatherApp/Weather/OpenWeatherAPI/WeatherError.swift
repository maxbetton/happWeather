//
//  WeatherError.swift
//  HappyWeather
//
//  Created by Maxime Betton on 17/03/2021.
//

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}

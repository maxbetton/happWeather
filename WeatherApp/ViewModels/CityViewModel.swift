//
//  CityViewModel.swift
//  HappWeather
//
//  Created by Maxime Betton on 17/03/2021.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class CityViewModel: ObservableObject {
    
    @Published var city: String = ""
    @Published var dataSource: [DailyWeatherRowViewModel] = []
    @Published var isAddPresented: Bool = false

   // fileprivate let cityReq = NSFetchRequest<City>(entityName: "City")
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    init(
      weatherFetcher: WeatherFetchable,
      scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
      self.weatherFetcher = weatherFetcher
      $city
        .dropFirst(1)
        .debounce(for: .seconds(0.5), scheduler: scheduler)
        .sink(receiveValue: fetchWeather(forCity:))
        .store(in: &disposables)
        print(disposables)
    }

    
    func fetchWeather(forCity city: String) {
      weatherFetcher.weeklyWeatherForecast(forCity: city)
        .map { response in
          response.list.map(DailyWeatherRowViewModel.init)
        }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              self.dataSource = []
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.dataSource = forecast
        })
        .store(in: &disposables)
        
    }
    
    
    func addCity(context: NSManagedObjectContext) -> Void {
        // requête pour recuperer les houses
        //self.cityReq.sortDescriptors = [NSSortDescriptor(keyPath: \City.city?, ascending: true)]
        
        // fait ma ville
        let newCity = City(context: context)
        newCity.city = self.city
        newCity.id = UUID()
        do {

            // je sauvegarde ma ville
            try context.save()
            self.resetValues()
            //ferme la AddView
            self.isAddPresented.toggle()
            print(self.isAddPresented)


        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCity(context: NSManagedObjectContext, city: NSManagedObject) -> Void {
        //je supprime l'object du context
        context.delete(city)
        do {
            // je sauvegarde l'etat du context
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func resetValues() -> Void {
        self.city = ""
    }
}

extension CityViewModel {
    var currentWeatherView: some View {
    return WeeklyWeatherBuilder.makeCurrentWeatherView(
      withCity: city,
      weatherFetcher: weatherFetcher
    )
  }
}

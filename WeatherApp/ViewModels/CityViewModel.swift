//
//  CityViewModel.swift
//  HappWeather
//
//  Created by Maxime Betton on 17/03/2021.
//

import Foundation
import CoreData

class CityViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var isAddPresented: Bool = false

    fileprivate let cityReq = NSFetchRequest<City>(entityName: "City")

    func addCity(context: NSManagedObjectContext) -> Void {
        // requête pour recuperer les houses
        self.cityReq.sortDescriptors = [NSSortDescriptor(keyPath: \City.cityName?, ascending: true)]
        
        // fait mon personnage
        let newCity = City(context: context)
        newCity.cityName = self.cityName
        newCity.id = UUID()
        print("panoleratquimix")
        do {
            print("panoleratquimix2")

            // je sauvegarde mon personnage
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
        self.cityName = ""
    }
}

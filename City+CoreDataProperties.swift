//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Maxime Betton on 31/03/2021.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var city: String?
    @NSManaged public var id: UUID?

}

extension City : Identifiable {

}

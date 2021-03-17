//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var id: UUID?

}

extension City : Identifiable {

}

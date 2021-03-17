//
//  EditView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

struct EditView: View {
    var city: City
    @ObservedObject var cityVM: CityViewModel
    @Environment(\.managedObjectContext) var context
    var placeholder: String = "unknown"


    var body: some View {
        Text("\(self.city.cityName ?? self.placeholder)")
    }
}


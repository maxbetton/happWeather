//
//  ListItem.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import SwiftUI

struct ListCities: View {
    @ObservedObject var city: City
    var placeholder: String = "unknown"
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(self.city.cityName ?? self.placeholder)")
                    .bold()
            }
        }
        .padding(.vertical, 10)
    }
}

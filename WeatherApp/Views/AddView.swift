//
//  AddView.swift
//  WeatherApp
//
//  Created by Maxime Betton on 17/03/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var context

    //@ObservedObject var viewModel: WeeklyWeatherViewModel
    @StateObject var cityVM = CityViewModel()
    
    //init(viewModel: WeeklyWeatherViewModel) {
     // self.viewModel = viewModel
    //}
    
    func verify() -> Bool {
        let result = (!self.cityVM.cityName.isEmpty == true) ? true : false
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                //searchField
                Section(header: Text("Ville")) {
                    TextField("Paris", text: self.$cityVM.cityName)
                }

                Button(action: {
                    self.cityVM.addCity(context: context)
                }) {
                    Text("Ajouter la ville")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarTitle("Ajouter")
            
        }
        
    }
}

//struct AddView_Previews: PreviewProvider {
    //static var previews: some View {
    //    AddView()
  //  }
//}
//private extension AddView {
//    var searchField: some View {
//      HStack(alignment: .center) {
//        TextField("e.g. Cupertino", text: $viewModel.city)
//      }
//    }
//}

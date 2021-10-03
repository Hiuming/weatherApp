//
//  CityNameView.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 10/09/2021.
//

import SwiftUI

/**
   - This is the city view
 */

struct CityNameView: View {
    var city : String
    var date : String
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10){
                 Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            }.foregroundColor(.white)
        }
    }
}

//struct CityNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

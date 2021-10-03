//
//  DailyWeatherView.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 10/09/2021.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var cityVM : CityViewModel
    var body: some View {
        ForEach(cityVM.weather.daily){ weather in
            LazyVStack{
                dailyCell(weather: weather)
            }
        }.padding([.trailing,.leading])
    }
    
    
    //--Create cell of table view ( daily table view)
    private func dailyCell(weather : DailyWeather) -> some View {
        HStack{
            Text(cityVM.getDateFor(timestamp: weather.dt).uppercased())
                .frame(width:50)
                .font(Font.system(size: 13))
            Spacer()
            
            Text("\(cityVM.getTempFor(temp: weather.temp.max)) | \(cityVM.getTempFor(temp: weather.temp.min))℉")
                .frame(width: 150)
            Spacer()
            
            cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
        }
        .foregroundColor(.white)
        .padding(.horizontal,40)
        .padding(.vertical,15)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.2),Color.gray.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                        .shadow(color: Color.white.opacity(0.1), radius: 2, x: 2, y: -2)
                        .shadow(color: Color.white.opacity(0.2), radius: 2, x: 2, y: 2))
    }
}

//struct DailyWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//       ContentView()
//    }
//}

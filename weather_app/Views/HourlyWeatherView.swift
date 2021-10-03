//
//  HourlyWeatherView.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 10/09/2021.
//

import SwiftUI


struct HourlyWeatherView: View {
    @ObservedObject  var cityVM : CityViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing : 20){
                ForEach(cityVM.weather.hourly){weather in
                    let icon = cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
                    let hour = cityVM.getTimeFor(timestamp: weather.dt)
                    let temp = cityVM.getTempFor(temp : weather.temp)
                    getHourlyView(hour: hour, image: icon, temp: temp)
                }
            }
        }.padding(.leading)
    }
    
    private func getHourlyView(hour:String, image : Image, temp : String) -> some View{
        VStack(spacing : 20){
            Text(hour)
            image.foregroundColor(.white)
            Text(temp + "℉")
        }
        .frame(height: 90)
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2),Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                        .shadow(color: Color.white.opacity(0.1), radius: 2, x: 2, y: -2)
                        .shadow(color: Color.white.opacity(0.2), radius: 2, x: 2, y: 2))
    }
    
}



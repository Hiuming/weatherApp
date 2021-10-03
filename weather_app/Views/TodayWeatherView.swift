//
//  TodayWeatherView.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 10/09/2021.
//

import SwiftUI

struct TodayWeatherView: View {
    @ObservedObject var cityVM : CityViewModel
    var body: some View {
        VStack(spacing : 10){
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing : 20){
                LottieView(name: cityVM.getLottieAnimationFor(icon: cityVM.weatherIcon))
                    .frame(width: 100, height: 100, alignment: .center)
                
                VStack(alignment: .leading){
                    Text("\(cityVM.temperature)℉")
                        .font(.system(size: 42))
                    Text(cityVM.condition)
                    
                }
            }
            HStack{
                Spacer()
                widgetView(image: "wind", color: Color.green.opacity(0.5), title: "\(cityVM.windSpeed)mi/hr")
                Spacer()
                widgetView(image: "drop.fill", color: Color.blue.opacity(0.5), title: "\(cityVM.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: Color.red.opacity(0.5), title: "\(cityVM.rainChances)")
                Spacer()
            }
            
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2),Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                        .shadow(color: Color.white.opacity(0.1), radius: 2, x: 2, y: -2)
                        .shadow(color: Color.white.opacity(0.2), radius: 2, x: 2, y: 2))
    }
    
    /**
          This widget view
     */
    private func widgetView(image : String, color : Color,title : String) -> some View{
        VStack{
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
            Text(title)
        }
        .frame(width:100)
        .padding(.bottom,10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
    }
}

//struct TodayWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

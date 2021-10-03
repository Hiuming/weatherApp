//
//  DailyWeather.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 10/06/2021.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    var dt: Int
    var temp: Temperature
    var weather: [WeatherDetail]
    
    enum CodingKey: String {
        case dt
        case temp
        case weather
    }
    
    init() {
        dt = 0
        temp = Temperature(max: 0.0, min: 0.0)
        // -- Fri 10 Sep 2021 added by hieuming
        weather = [WeatherDetail(main: "", description: "", icon: "")]
        //--Finish adding
    }
}

extension DailyWeather {
    var id: UUID {
        return UUID()
    }
}

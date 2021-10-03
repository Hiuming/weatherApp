//
//  CityViewModel.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 10/06/2021.
//

import CoreLocation
import SwiftUI

final class CityViewModel: ObservableObject{
    
    
    @Published var weather = WeatherResponse.empty()
    @Published var city : String = "San Francisco"{
        didSet{
           getLocaton()
            
        }
    }
    
    private lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    private lazy var dayFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init (){
         getLocaton()
    }
    
    
    var date :String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        
        if weather.current.weather.count > 0{
            return weather.current.weather[0].icon
            
        }
        
        //if api is not called -> default icon
        return "sun.max.fill"
    }
   
    var temperature: String{
        return doubleFormatToString(input: weather.current.temp)
    }
    
    var condition: String{
        if weather.current.weather.count > 0{
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String{
        return doubleFormatToString(input: weather.current.wind_speed)
    }
    
    var humidity: String{
        return String(format: "%d%%", weather.current.humidity)
    }
    var rainChances : String{
        return String(format:"%0.0f%%",weather.current.dew_point)
    }
    
    // ----- GET TIME FUNCTION ---
    
    func getTimeFor(timestamp: Int) -> String{
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getDateFor(timestamp : Int) -> String{
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    // -- GET TEMPERATURE
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    
    //--- CONVERT FUCTION ---
    
    func doubleFormatToString(input : Double ) -> String{
        return String(format: "%0.1f", input)
    }
    
// MARK: - GET LOCATION, GET WEATHER, GET WEATHER IN THAT CITY
    
    
    /**
              - This function is used to get the first locaiton from placmarks list
        
     */
    private func getLocaton() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first{
                self.getWeather(coord: place.location?.coordinate)
            }
            
        }
    }
    /**
     - This function get the api call at exact lat and long (See the API+Extension for details)
     */
    
    
    private func getWeather(coord : CLLocationCoordinate2D?){
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        }
        else{
            let urlString = API.getURLFor(lat: 37, lon: -141);
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    
  /**
     - This fuction fetch the weather in the input city
     */

    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
// MARK: -GET LOTTIE ANIMATION, GET ICON ( FROM API CALL ):
    
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
            case "01d":
                return "dayClearSky"
            case "01n":
                return "nightClearSky"
            case "02d":
                return "dayFewClouds"
            case "02n":
                return "nightFewClouds"
            case "03d":
                return "dayScatteredClouds"
            case "03n":
                return "nightScatteredClouds"
            case "04d":
                return "dayBrokenClouds"
            case "04n":
                return "nightBrokenClouds"
            case "09d":
                return "dayShowerRains"
            case "09n":
                return "nightShowerRains"
            case "10d":
                return "dayRain"
            case "10n":
                return "nightRain"
            case "11d":
                return "dayThunderstorm"
            case "11n":
                return "nightThunderstorm"
            case "13d":
                return "daySnow"
            case "13n":
                return "nightSnow"
            case "50d":
                return "dayMist"
            case "50n":
                return "dayMist"
            default:
                return "dayClearSky"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case "01d":
                return Image(systemName: "sun.max.fill") //"clear_sky_day"
            case "01n":
                return Image(systemName: "moon.fill") //"clear_sky_night"
            case "02d":
                return Image(systemName: "cloud.sun.fill") //"few_clouds_day"
            case "02n":
                return Image(systemName: "cloud.moon.fill") //"few_clouds_night"
            case "03d":
                return Image(systemName: "cloud.fill") //"scattered_clouds"
            case "03n":
                return Image(systemName: "cloud.fill") //"scattered_clouds"
            case "04d":
                return Image(systemName: "cloud.fill") //"broken_clouds"
            case "04n":
                return Image(systemName: "cloud.fill") //"broken_clouds"
            case "09d":
                return Image(systemName: "cloud.drizzle.fill") //"shower_rain"
            case "09n":
                return Image(systemName: "cloud.drizzle.fill") //"shower_rain"
            case "10d":
                return Image(systemName: "cloud.heavyrain.fill")//"rain_day"
            case "10n":
                return Image(systemName: "cloud.heavyrain.fill") //"rain_night"
            case "11d":
                return Image(systemName: "cloud.bolt.fill") //"thunderstorm_day"
            case "11n":
                return Image(systemName: "cloud.bolt.fill") //"thunderstorm_night"
            case "13d":
                return Image(systemName: "cloud.snow.fill") //"snow"
            case "13n":
                return Image(systemName: "cloud.snow.fill") //"snow"
            case "50d":
                return Image(systemName: "cloud.fog.fill") //"mist"
            case "50n":
                return Image(systemName: "cloud.fog.fill") //"mist"
            default:
                return Image(systemName: "sun.max.fill")
        }
    }
    
    func getWeatherBgFor(icon: String) -> Image {
        switch icon {
        case "01n","02n","03n","04n":
            return Image("112-1")
        case "09d","09n","10d","10n","11d","11n","50d","50n":
            return Image("112")
        case "13d","13n":
            return Image("112-snow")
            default:
                return Image("112-sun")
        }
    }
    
    
}


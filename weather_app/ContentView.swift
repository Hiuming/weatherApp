//
//  ContentView.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 08/06/2021.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @ObservedObject var cityVM = CityViewModel()
    @State private var isSelected : Bool = false
    //-- get Sprite Animation by condition --
    private func getSpriteAnimation(weatherCondition : String?) ->  SpriteView
    {
        if weatherCondition != nil{
        switch weatherCondition {
        case "Rain":
            return  SpriteView(scene: SpriteAnimation(effectName: "RainEffect.sks"),options: [.allowsTransparency])
        case "Snow":
            return  SpriteView(scene: SpriteAnimation(effectName: "Snow.sks"),options: [.allowsTransparency])
        default:
            return SpriteView(scene: SKScene(),options: [.allowsTransparency])
        }
        }
        else{
            debugPrint("error")
            return SpriteView(scene: SKScene(),options: [.allowsTransparency])
        }
    }
    //----- end function -----
    
    
    var body: some View {
        //SpriteAnimation.effectName = cityVM.condition
        ZStack(alignment : .bottom){
            if(cityVM.condition == "Rain"){
            self.getSpriteAnimation(weatherCondition: "RainEffect")
            }
            else if (cityVM.condition == "Snow"){
                self.getSpriteAnimation(weatherCondition: "Snow")
            }
           
            VStack(spacing : 0){
                MenuHeaderView(cityVM: cityVM,isSelected: $isSelected)
                ScrollView(showsIndicators: false){
                    CityView(cityVM: cityVM)
                }
               
            }.padding(.top,30)
        }  .background(cityVM.getWeatherBgFor(icon: cityVM.weatherIcon).resizable()
                    .shadow(color: Color.white.opacity(0.1), radius: 2, x: 2, y: -2)
                    .shadow(color: Color.white.opacity(0.2), radius: 2, x: 2, y: 2))
        .edgesIgnoringSafeArea(.all)
   }
 
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}


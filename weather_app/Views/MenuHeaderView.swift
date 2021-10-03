//
//  MenuHeaderView.swift
//  weather_app
//
//  Created by Huynh Minh Hieu on 09/09/2021.
//

import SwiftUI
/**
   - This is the search bar view,etc...
 
 */


struct MenuHeaderView: View {
    // -- create observe object to recive from city view model
    @ObservedObject var cityVM : CityViewModel
    
    @State private var searchTerm = "San Francisco"
    
    @Binding var isSelected : Bool
    
    
    
    var body: some View {
        HStack{
            TextField("",text:$searchTerm)
                .padding(.leading,20)
            
            //--Button UI configuration
            Button {
                cityVM.city = searchTerm
            } label : {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white).frame(height:40).opacity(0.2)
                    Image(systemName: "location.fill")
                }
            }.frame(width:50, height: 50)
            .padding(.trailing,10)
            //-- end button UI configuration
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack (alignment: .leading, content: {
            Image(systemName: "maginifyingglass")
                .foregroundColor(.white)
                .padding(.leading,40)
            RoundedRectangle(cornerRadius: 20)
                .fill( Color.white.opacity(0.2)) //: Color.blue.opacity(0.2))
                .frame(width: UIScreen.main.bounds.width*0.92,height : 60)
        }))
    }
}

//struct MenuHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

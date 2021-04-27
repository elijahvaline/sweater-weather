//
//  ContentView.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 4/18/21.
//

import SwiftUI

struct ContentView: View {
    @State var temp:Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
           
            VStack(spacing: 10){
                ZStack{
                    
                    
                    RoundedRectangle(cornerRadius: 20)
//                        .gradientRec(colors: [Color("MainColor1"), Color("MainColor2")])
                        .foregroundColor(.white)
                        .shadow(radius: 3 )
                    Text("The Temperature is: " + String(temp))
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .gradientForeground(colors: [Color("MainColor1"), Color("MainColor2")])
                        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    
                }
                .frame(width: geometry.size.width*0.9, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                        .gradientRec(colors: [Color("MainColor1"), Color("MainColor2")])
                        .foregroundColor(.white)
                        .shadow(radius: 3 )
                    Text("The Temperature is: " + String(temp))
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    
                }
                .frame(width: geometry.size.width*0.9, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
                
                Button(action: {
                    reload()
                }) {
                    Text("Refresh")
                }

               
            }.padding(.leading, geometry.size.width * 0.05)
            
            
        
        }
    }
    
    func reload(){
        
       
            
            ServerUtils.getWeather(returnWith:  { response, success in
                if (!success) {
                    
                    // Show error UI here
                    print("OH NO IT FAILED")
                    return;
                }
                
                let totalWeather:weather = response!
                temp = totalWeather.current.temp
            
                
                // Cant modify state variable directly multiple times without swiftui class
              
                
            })
    }
}

extension Shape  {

    public func gradientRec(colors: [Color]) -> some View {
        self.fill(LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))

    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

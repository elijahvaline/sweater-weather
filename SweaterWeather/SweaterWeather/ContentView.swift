//
//  ContentView.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 4/18/21.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    
    @State var temp:Double = 0.0
    @State var sweaterFactor:Int = 0
    @State var loading = true
    @State var lat = 0.0
    @State var lon = 0.0
    @State private var blurAmount: CGFloat = 5
    @State var progress:Float = 1.0
    @ObservedObject private var locationManager = LocationManager()
    @ObservedObject private var settings = Settings()
    @State var sweater:String = ""
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                        Color("Grey")
                            .edgesIgnoringSafeArea(.all)
                
                        VStack(spacing: 5){
                            
                            Image(systemName: "smoke.fill")
                                .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                                .font(.system(size: 35))
                            
                            ScrollView {
                                
                                
                                    GeometryReader { geo in
                                    VStack{
                                        
        //
                                        HStack{
                                            Spacer()
                                            Text(self.sweater)
                                                
                                                .font(.system(size: max(1, (25 - abs(60-(geo.frame(in: .global).midY/1.5))))))
                                                .fontWeight(.medium)
                                                .padding(.bottom, 50)
                                                .padding(.top, 35)
                                                .opacity(1.0 - (0.1 * Double(20 - geo.frame(in: .global).midY)))
                                              
                                            Spacer()
                                        }
                                            
                                            
        //                                }
                                            
                                                
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .gradientRec(start: .topTrailing, end: .bottomLeading, colors: [Color("MainColor1"), Color("MainColor2")])
                                                    .frame(width: geometry.size.width*0.9, height: 200)
                                                
                                                
                                                HStack{
                                                    
                                                    VStack{
                                                        
                                                        
                                                        Text(String(sweaterFactor))
                                                            .font(.system(size: 70))
                                                            .fontWeight(.semibold)
                                                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                            .foregroundColor(.white)
                                                       
                                                        Text("Sweater Factor")
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.white)
                                                    }.frame(width: 150)
                                                    
                                                    
                                                    RoundedRectangle(cornerRadius: 1)
                                                        .frame(width: 3, height: 150)
                                                        .foregroundColor(.white)
                                                    
                                                    VStack{
                                                        Text(String(sweaterFactor - settings.sweaterThreshhold))
                                                            .font(.system(size: 70))
                                                            .fontWeight(.semibold)
                                                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                            .foregroundColor(.white)
                                                        //                                .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                                                        Text(" Differential ")
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.white)
                                                    }.frame(width: 150)
                                                }
                                            }
                                        
                                        
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 15)
                                                .gradientRec(start:.topLeading, end: .bottomTrailing, colors: [Color("MainColor2"), Color("MainColor1")])
                                                .frame(width: geometry.size.width*0.9, height: 400)
                                            
                                            
                                            
                                                
                                                VStack{
                                                    
                                                    
                                                    Text(String(settings.sweaterThreshhold))
                                                        .font(.system(size: 70))
                                                        .fontWeight(.semibold)
                                                        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                        .foregroundColor(.white)
                                                   
                                                    Text("Your Sweater Threshold")
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.white)
                                                    
                                                    RoundedRectangle(cornerRadius: 1)
                                                        .frame(width: geometry.size.width * 0.8, height: 3)
                                                        .foregroundColor(.white)
                                                        .padding(.vertical, 30)
                                                    
                                                    Text("How was your recommendation today?")
                                                        .foregroundColor(.white)
                                                        .fontWeight(.semibold)
                                                    HStack(spacing: 30){
                                                        
                                                        Button(action: {
                                                            settings.decrement()
                                                            }) {
                                                            ZStack{
                                                                Circle()
                                                                    .foregroundColor(.white)
                                                                    .frame(width: 75, height:75)
                                                                Text("🥵")
                                                                    .font(.system(size: 40))
                                                            }
                                                            
                                                        }
                                                        
                                                        RoundedRectangle(cornerRadius: 1)
                                                            .foregroundColor(.white)
                                                            .frame(width: 3, height: 100)
                                                        Button(action: {
                                                            settings.increment()
                                                        }) {
                                                            ZStack{
                                                                Circle()
                                                                    .foregroundColor(.white)
                                                                    .frame(width: 75, height:75)
                                                                Text("🥶")
                                                                    .font(.system(size: 40))
                                                            }
                                                            
                                                        }
                                                    }
                                                        
                                                }
                                                
                                              
                                                
                                            
                                        }.padding(.top, 10)

                                            Spacer()
                                            
                                
                                    }
                                    }
                                    
                               
                                    
                                
                            
                            }
                        
                            
                        }.frame(width: geometry.size.width, height: geometry.size.height)
                
//
//                Rectangle()
//                    .foregroundColor(.white)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .isHidden(!loading)
//                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//
//                ActivityIndicatorView(isVisible: $loading)
//                    .frame(width: geometry.size.height*0.1, height: geometry.size.height*0.1)
//                    .foregroundColor(Color("MainColor1"))
            }
//            .padding(.vertical, 30.0)
//            .background(Color("Grey")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .onReceive(locationManager.$location, perform: { newLocation in
                if let newLocation = newLocation {
                    reload(location: newLocation.coordinate)
                }
            })
            
            
        }
    }
    
    
    
    
    func reload(location: CLLocationCoordinate2D){
        
        //        let coor = self.locationManager.location != nil ?
        //            self.locationManager.location!.coordinate :
        //            CLLocationCoordinate2D()
        //
        
        ServerUtils.getWeather(laty:location.latitude, lony:location.longitude, returnWith:  { response, success in
            if (!success) {
                
                // Show error UI here
                print("OH NO IT FAILED")
                return;
            }
            
            let totalWeather:weather = response!
            sweaterFactor = SweaterFunctions.sweaterFactor(currentWeather: totalWeather)
            lon = totalWeather.lon
            lat = totalWeather.lat
            
            if (sweaterFactor <= settings.sweaterThreshhold){
                self.sweater = "Wear a sweater."
            
            }
            else{
                self.sweater = "Don't wear a sweater."
            }
            
            // Cant modify state variable directly multiple times without swiftui class
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                
                loading = false
                
                
            }
        })
    }
}

extension Shape  {
    
    public func gradientRec(start:UnitPoint, end: UnitPoint, colors: [Color]) -> some View {
        self.fill(LinearGradient(gradient: .init(colors: colors), startPoint: start, endPoint:end))
        
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


extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                ScrollView {
                    
                    VStack(spacing: 10){
                        
                        
                        ZStack{
                            Image("background-1")
                                .frame(width: geometry.size.width)
                                
                            VStack{
                                Text("You should wear a sweater today")
                                    .foregroundColor(.white)
                                    .font(.system(size: 35))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 40)
                                    .frame(width: geometry.size.width)
                                
                                Spacer()
                            }
                        }
                        
                            
                        
                        ZStack{
                            CircleProgress(progress: $progress, color: Color("MainColor1"))
                                .frame(width: geometry.size.width*0.6, height: geometry.size.width*0.5)
                            
                            VStack{
                                Text(String(sweaterFactor))
                                    .font(.system(size: 70))
                                    .fontWeight(.semibold)
                                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                //                                .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                                Text("Sweater Factor")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                //                                .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                                
                            }
                            
                            
                            
                            
                        }.padding(.bottom, 10)
                        .padding(.top, 20)
                        
                        
                        
                        
                        //                        .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                        //                    ZStack{
                        //
                        //                        RoundedRectangle(cornerRadius: 20)
                        //                            .gradientRec(colors: [Color("MainColor1"), Color("MainColor2")])
                        //                            .foregroundColor(.white)
                        //    //                        .shadow(radius: 3 )
                        //                        VStack{
                        //                            Text(String(sweaterFactor))
                        //                                .font(.system(size: 50))
                        //                                .foregroundColor(.white)
                        //                                .fontWeight(.semibold)
                        //                                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        //
                        //                            Text("Today's sweater factor")
                        //                                .font(.system(size: 25))
                        //
                        //                                .foregroundColor(Color.white)
                        //                                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        //                        }
                        //
                        //
                        //
                        //                    }
                        //                    .frame(width: geometry.size.width*0.9, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        
                        
                        Spacer()
                        
                        
                    }
                }
                //                .padding(.leading, geometry.size.width * 0.05)
                
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .isHidden(!loading)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                ActivityIndicatorView(isVisible: $loading)
                    .frame(width: geometry.size.height*0.1, height: geometry.size.height*0.1)
                    .foregroundColor(Color("MainColor1"))
            }
            
            .onReceive(locationManager.$location, perform: { newLocation in
                if let newLocation = newLocation {
                    reload(location: newLocation.coordinate)
                }
            })
            
            //            .onAppear(){
            //                reload(location: newLocation.coordinate)
            //            }
            
            
            
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
            
            // Cant modify state variable directly multiple times without swiftui class
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                
                loading = false
                
                
            }
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


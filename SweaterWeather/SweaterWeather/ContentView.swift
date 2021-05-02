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
                
                        VStack(spacing: 10){
                            
                            Image(systemName: "smoke.fill")
                                .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                                .font(.system(size: 60))
                            
                            HStack{
                                Text("Dashboard")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .frame(alignment: .leading)
                                    .padding(.leading, 20)
                                    
                                Spacer()
                            }
                            ZStack{
                                
//                                RoundedRectangle(cornerRadius: 20)
//                                    .gradientRec(colors: [Color("MainColor1"), Color("MainColor2")])
                                    
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
//                                    .padding(.all, 2)
                                VStack{
                                    
                                    Text("Yes!").fontWeight(.heavy)

                                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                    
                                    Text("You should wear a sweater today!")
                                        .font(.system(size: 23))

                                    
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
                                        }
                                        
                                    }
                                    
                                    .padding(.bottom, 10)
                                    .padding(.top, 20)
                                }
                                
                            
          
                            }.frame(width:geometry.size.width*0.9, height: 350)
                            .shadow(color: Color.black.opacity(0.15), radius: 5)
                            
                            
                            Spacer()
                            
                        
                    
                    
                        }.frame(width: geometry.size.width, height: geometry.size.height)
                        .padding(.top, 15)
                
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
//            .background(Color(UIColor.systemGray6)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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

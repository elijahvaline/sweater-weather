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
    @State var responsey = true
    @State var scale:CGFloat = 1.0
    @State var white = true
    @State var op = 1.0

    
    
    var body: some View {
        ZStack{
            
        
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
                                        
                                        //                                                .font(.system(size: max(1, (25 - abs(60-(geo.frame(in: .global).midY/1.5))))))
                                        .font(.system(size: max(1, (25 - abs(((geo.frame(in: .global).midY - 91)/2))))))
                                        .fontWeight(.medium)
                                        .padding(.bottom, 50)
                                        .padding(.top, 35)
                                        .opacity(1.0 - (0.03 * abs(Double(geo.frame(in: .global).midY - 91))))
                                    
                                    Spacer()
                                    
                                }
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .gradientRec(start: .topTrailing, end: .bottomLeading, colors: [Color("MainColor1"), Color("MainColor2")])
                                        .frame(width: geometry.size.width*0.9, height: 200)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5.0)
                                    
                                    
                                    HStack{
                                        
                                        VStack{
                                            
                                            
                                            
                                            Text(String(sweaterFactor))
                                                .font(.system(size: 70))
                                                .fontWeight(.semibold)
                                                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(.white)
                                            
                                            Text("Today's Sweater Factor")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                        }.frame(width: 150)
                                        
                                        
                                        RoundedRectangle(cornerRadius: 1)
                                            .frame(width: 3, height: 150)
                                            .foregroundColor(.white)
                                        
                                        VStack{
                                            
                                            if (sweaterFactor - settings.sweaterThreshhold > 0){
                                                Text("+" + String(sweaterFactor - settings.sweaterThreshhold))
                                                    .font(.system(size: 70))
                                                    .fontWeight(.semibold)
                                                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                    .foregroundColor(.white)
                                            }
                                            else {
                                                Text(String(sweaterFactor - settings.sweaterThreshhold))
                                                    .font(.system(size: 70))
                                                    .fontWeight(.semibold)
                                                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                    .foregroundColor(.white)
                                            }
                                            
                                            //                                .gradientForeground(colors: [Color("MainColor1"),Color("MainColor2")])
                                            Text("Sweater Differential")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                        }.frame(width: 150)
                                    }
                                }
                                
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .gradientRec(start:.topLeading, end: .bottomTrailing, colors: [Color("MainColor2"), Color("MainColor1")])
                                        .frame(width: geometry.size.width*0.9, height: 400)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5.0)
                                    
                                    VStack{
                                        
                                        
                                        Text(String(settings.sweaterThreshhold))
                                            .font(.system(size: 70))
                                            .fontWeight(.semibold)
                                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                        
                                        Text("Your Sweater Threshold")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                        
                                        RoundedRectangle(cornerRadius: 1)
                                            .frame(width: geometry.size.width * 0.8, height: 3)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 20)
                                        
                                        
                                        ZStack{
                                            
                                            Text("Thanks for the response!")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 20))
                                                .isHidden(responsey)
                                            
                                            VStack{
                                                
                                                Text("How was your recommendation yesterday?")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: geometry.size.width * 0.8)
                                                    .isHidden(!responsey)
                                                
                                                
                                                
                                                
                                                HStack(spacing: 20){
                                                    
                                                    
                                                    Button(action: {
                                                        settings.decrement()
                                                        settings.dater()
                                                        responsey = false
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
                                                        settings.dater()
                                                        responsey = false
                                                    }) {
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.white)
                                                                .frame(width: 75, height:75)
                                                            Text("🙂")
                                                                .font(.system(size: 40))
                                                        }
                                                        
                                                    }
                                                    
                                                    RoundedRectangle(cornerRadius: 1)
                                                        .foregroundColor(.white)
                                                        .frame(width: 3, height: 100)
                                                    Button(action: {
                                                        settings.increment()
                                                        settings.dater()
                                                        responsey = false
                                                    }) {
                                                        ZStack{
                                                            Circle()
                                                                .foregroundColor(.white)
                                                                .frame(width: 75, height:75)
                                                            Text("🥶")
                                                                .font(.system(size: 40))
                                                        }
                                                        
                                                    }
                                                }.isHidden(!responsey)
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }.padding(.top, 10)
                                
                                
                                //                                Divider().padding(.vertical, 20)
                                //
                                //                                HStack(spacing: geometry.size.width * 0.05){
                                //
                                //                                    ZStack{
                                //                                        RoundedRectangle(cornerRadius: 15.0)
                                //                                            .foregroundColor(Color("Foreground"))
                                //                                            .shadow(color: Color.black.opacity(0.1), radius: 5.0)
                                //
                                //
                                //                                    }.frame(width: geometry.size.width * 0.425, height: geometry.size.width * 0.425)
                                //
                                //                                    ZStack{
                                //                                        RoundedRectangle(cornerRadius: 15.0)
                                //                                            .foregroundColor(Color("Foreground"))
                                //                                            .shadow(color: Color.black.opacity(0.1), radius: 5.0)
                                //
                                //                                    }.frame(width: geometry.size.width * 0.425, height: geometry.size.width * 0.425)
                                //
                                //
                                //
                                //
                                //
                                //
                                //                                }.padding(.top, 10)
                                

                                // Add stuff to the main scroll view here
                                
                                Spacer()
                                
                                
                            }
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                }.frame(width: geometry.size.width, height: geometry.size.height)
                
//                Rectangle()
//                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Color("Grey")
                    .isHidden(white)
                    .opacity(op)
                
                
                LinearGradient(gradient: Gradient(colors: [Color("MainColor1"), Color("MainColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                    .isHidden(!loading)

                Image(systemName: "smoke.fill")
                    .resizable()
                    .foregroundColor(Color("Grey"))
                    .frame(width: 200 * scale, height: 150 * scale)
                    .scaleEffect(scale)
                    .isHidden(!loading)
//
//
             
            }
            .onReceive(locationManager.$location, perform: { newLocation in
                if let newLocation = newLocation {
                    reload(location: newLocation.coordinate)
                }
                
               
            })
            
        
        
            
            
            
          }
        }
    }
    
    
    
    
    func reload(location: CLLocationCoordinate2D){
        
        
        ServerUtils.getWeather(laty:location.latitude, lony:location.longitude, returnWith:  { response, success in
            if (!success) {
                
                // Show error UI here
                print("OH NO IT FAILED")
                return;
            }
            
            let datey = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let result = formatter.string(from: datey)
            
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
            
            
            if (settings.date == result){
                responsey = false
            }
            // Cant modify state variable directly multiple times without swiftui class
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
//
                withAnimation(.easeIn(duration: 0.2)) { scale = 6.0 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

                    white = false
                    loading = false
                    scale = 1
//                    white = true
                    
                    withAnimation(.easeIn(duration: 0.08)) { op = 0 }
                    
                    

                }
                    
            
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

extension View {
    func animate(using animation: Animation = Animation.easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

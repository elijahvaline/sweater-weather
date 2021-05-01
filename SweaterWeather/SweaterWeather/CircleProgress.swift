//
//  CircleProgress.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 5/1/21.
//

import SwiftUI

struct CircleProgress: View {
    @Binding var progress: Float
    var color:Color
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .fill(LinearGradient(gradient: .init(colors: [Color("MainColor1"),Color("MainColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .opacity(0.3)
                    .rotationEffect(Angle(degrees: 270.0))
//                    .foregroundColor(color)
                    
                
                Circle()
                    
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(color)
                    .fill(LinearGradient(gradient: .init(colors: [Color("MainColor1"),Color("MainColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .rotationEffect(Angle(degrees: 270.0))
                    
                    
                    
                    

            }
        }
}


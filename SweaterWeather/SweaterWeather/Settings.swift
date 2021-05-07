//
//  Settings.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 5/7/21.
//

import SwiftUI

class Settings: ObservableObject {
    @Published var sweaterThreshhold:Int {
        didSet {
            UserDefaults.standard.set(sweaterThreshhold, forKey: "threshhold")
        }
    }
    
    init() {
        self.sweaterThreshhold = UserDefaults.standard.object(forKey: "threshhold") as? Int ?? 60
    }
    
    func increment(){
        
        sweaterThreshhold+=1
    }
    func decrement(){
        
        sweaterThreshhold-=1
    }
}

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
    @Published var date:String {
        didSet{
            UserDefaults.standard.set(date, forKey: "date")
        }
    }
    
    init() {
        self.sweaterThreshhold = UserDefaults.standard.object(forKey: "threshhold") as? Int ?? 57
        self.date = UserDefaults.standard.object(forKey: "date") as? String ?? "0/0/0000"
    }
    
    func increment(){
        
        sweaterThreshhold+=1
    }
    func decrement(){
        
        sweaterThreshhold-=1
    }
    func dater(){
        let datey = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let result = formatter.string(from: datey)
        date = result
    }
    
    
}

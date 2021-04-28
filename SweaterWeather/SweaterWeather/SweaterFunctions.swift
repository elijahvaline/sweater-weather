//
//  SweaterFunctions.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 4/28/21.
//

import Foundation

class SweaterFunctions {

    static func sweaterFactor(currentWeather:weather) -> Int {
        var sweaterFactor = 0.0
        for n in 0...11 {
            var current:hourWeather = currentWeather.hourly[n]
            sweaterFactor += current.temp
            sweaterFactor -= current.wind_speed * 0.5
            sweaterFactor += 10.0-(10.0*(Double(current.clouds) * 0.01))
            sweaterFactor += current.uvi
            sweaterFactor += 5.0*(Double(current.humidity)*0.01)
        }
        sweaterFactor /= 12
        //runs hot modifys it
        //Take latitude and use 45 as a base point, anything above and the sweater factor decreases, anything below and the sweater factor increases

        return Int(sweaterFactor)
    }
    
}

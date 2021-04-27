//
//  ServerUtils.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 4/18/21.
//

import Foundation


struct weather: Decodable {
    let lat:Double
    let lon:Double
    let timezone:String
    let timezone_offset:Int
    let current:curWeather
    let hourly:[hourWeather]
}

struct curWeather: Decodable{
    let dt:Int
    let sunrise:Int
    let sunset:Int
    let temp:Double
    let feels_like:Double
    let pressure:Int
    let humidity:Int
    let dew_point:Double
    let uvi:Double
    let clouds:Int
    let visibility:Int
    let wind_speed:Double
    let wind_deg:Int
    let weather:[lilWeather]
    
    
}
struct hourWeather: Decodable{
    let dt:Int
    let temp:Double
    let feels_like:Double
    let pressure:Int
    let humidity:Int
    let dew_point:Double
    let uvi:Double
    let clouds:Int
    let visibility:Int
    let wind_speed:Double
    let wind_deg:Int
    let weather:[lilWeather]
    
    
}

struct lilWeather: Decodable{
    
    let id:Int
    let main:String
    let description:String
    let icon:String
}

extension Data {
    mutating func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

/// Controller class with static functions for bring information from the model to the views.
class ServerUtils {
    
    static let serverUrl = MyVariables.address
    
    /// Gets all the posts in the db
    /// - Parameter returnWith: Asychronous Callback
    /// - Returns: The array of post objects and success boolean
    static func getWeather(returnWith: @escaping (weather?, Bool)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        if let url = URL(string: serverUrl) {
            let task = session.dataTask(with: url, completionHandler: { data1, response, error in
                if (error != nil) {
                    returnWith(nil, false)
                    return
                }
                
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        let postSet = try decoder.decode(weather.self, from: Data(dataString.utf8))
                        returnWith(postSet, true)
                        
                    }
                        
                    catch let jsonError {
                        print("Error Serializing JSON", jsonError)
                        returnWith(nil, false)
                    }
                } else {
                  returnWith(nil, false)
                }
                
            })
            
            task.resume()
            
        }
    }
}

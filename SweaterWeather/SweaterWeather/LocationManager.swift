//
//  LocationManager.swift
//  SweaterWeather
//
//  Created by Elijah Valine on 4/27/21.
//


import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate
{
 
    
    @Published var location: CLLocation? = nil
    @Published var locationAllowed:Bool = true
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthoization status: CLAuthorizationStatus, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        self.location = location
    }
    
    func locationManager(_ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
                           case .restricted, .denied:
                              // Disable your app's location features
                               print("Should be false")
                              locationAllowed = false
                            
                              break;
                                 
                           case .authorizedWhenInUse:
                              // Enable your app's location features.
                              locationAllowed = true
                               self.location =  manager.location
                              break;
                                 
                           case .authorizedAlways:
                              // Enable or prepare your app's location features that can run any time.
                              locationAllowed = true
                              self.location =  manager.location
                              break;
                                 
                           case .notDetermined:
                              locationAllowed = true
                              self.location =  manager.location
                              break;
                        }
    }


}


//
//  UserLocationManager.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import MapKit

class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled(){
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Show an allert letting them know this is off and to go turn it on.")
        }
    }
    
    private func checkLocationAuthorisation(){
        
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus{
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restrickted.")
            case .denied:
                print("You have denied this app location permission.")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
            @unknown default:
                break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorisation()
    }
    
}



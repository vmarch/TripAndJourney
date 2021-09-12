//
//  MapView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
 
    @Binding var listData: [Place]
    @State private var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        if(!listData.isEmpty){
         
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            
            mapView.removeAnnotations(mapView.annotations)
            
            var allPins: [MKPointAnnotation] = []
            
            for place in listData {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
                annotation.title = place.name
                annotation.subtitle = place.description
                allPins.append(annotation)
            }
            mapView.addAnnotations(allPins)
            
        }
    }
}

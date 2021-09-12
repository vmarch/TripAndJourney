//
//  GridView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import MapKit
import SwiftUI

struct GridView: View {
    var items  = [GridItem(.adaptive(minimum: 100))]
    
    @Binding var listData: [Place]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
          
                LazyVGrid(
                    columns: items,
                  
                    spacing: 8
                ) {
                    ForEach(self.listData, id: \.id) { place in
                        NavigationLink(destination: PlaceDetailView(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), place:place), label: {
                    GridViewCell(place: place)
                        })
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    @State static var listData: [Place] = [Place(id: "0", name: "Titel of Something", description: "Some Info about Something as multiline Text", categorie: 1, ranking: 3, lat: 55.5555, lon: 10.1010, img: "someimage", uiimage: ImageLoader().loadImageFromURL(str: "\(ConectData().testImageUrl)")), Place(id: "0", name: "Titel of Something", description: "Some Info about Something as multiline Text", categorie: 1, ranking: 3, lat: 55.5555, lon: 10.1010, img: "someimage", uiimage: ImageLoader().loadImageFromURL(str: "\(ConectData().testImageUrl)")), Place(id: "0", name: "Titel of Something", description: "Some Info about Something as multiline Text", categorie: 1, ranking: 3, lat: 55.5555, lon: 10.1010, img: "someimage", uiimage: ImageLoader().loadImageFromURL(str: "\(ConectData().testImageUrl)"))]
    static var previews: some View {
        GridView(listData: $listData)
    }
}

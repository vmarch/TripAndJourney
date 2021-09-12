//
//  PlaceDetailView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import MapKit
import SwiftUI

struct PlaceDetailView: View {
    
    @State var region:MKCoordinateRegion
    @State var place: Place
    var body: some View{
        
        NavigationView{
            
            VStack(alignment: .center, spacing: 10){
                
                Map(coordinateRegion: $region)
                    .frame(height: 250)
                HStack{
                }
                Image(place.img)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(.horizontal)
                HStack(alignment: .center){
                    RankingView(name: "Ranking:", rankingCount: place.ranking, filledImageName: "star.fill", emptyImageName: "star", filledImageColor: Color.yellow, emptyImageColor: Color.gray, iconsFrameWidth: 10).padding()
                    
                    
                    Spacer()
                    Text("\(place.getCategorieAsString())")
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                }
                Divider()
                Text(place.description)
                    .font(.title3)
                //                .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(16)
                Spacer()
            }
        }.navigationBarTitle(Text(place.name),displayMode: .inline)
        
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlaceDetailView(
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 53.5440629, longitude: 9.901209),
                                       span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                      ),
            place: Place(id: "0", name: "Titel of Something", description: "Some Info about Something as multiline Text", categorie: 1, ranking: 3, lat: 55.5555, lon: 10.1010, img: "someimage", uiimage: ImageLoader().loadImageFromURL(str: "\(ConectData().testImageUrl)")
                        )
        )
    }
}


//
//  GridViewCell.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct GridViewCell: View {
    var place:Place
    var body: some View{
        VStack(spacing: 4){
            Image(place.img)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding(2)
            VStack(alignment: .leading, spacing: 4){
                Text(place.name)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 6)
                Text(place.description)
                    .font(.subheadline)
                    .lineLimit(3)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 6)
                
               
                RankingView(name: "", rankingCount: place.ranking, filledImageName: "star.fill", emptyImageName: "star", filledImageColor: Color.yellow, emptyImageColor: Color.gray, iconsFrameWidth: 7)
                    .padding(.bottom, 4)
                
            }
        }.background(Color.white)
            .cornerRadius(12)
    }
}


struct GridViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GridViewCell(place: Place(id: "0", name: "Titel of Something", description: "Some Info about Something as multiline Text",  categorie: 1, ranking: 3, lat: 55.5555, lon: 10.1010, img: "someimage", uiimage: ImageLoader().loadImageFromURL(str: "\(ConectData().testImageUrl)")))
    }
}

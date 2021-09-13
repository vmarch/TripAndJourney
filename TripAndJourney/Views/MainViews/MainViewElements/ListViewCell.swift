//
//  ListViewCell.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//


import SwiftUI
struct ListViewCell: View{
    
    var place:Place
    var body: some View{
        HStack(spacing: 8){
            Image(uiImage: place.uiimage)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .cornerRadius(8)
                .padding(.vertical, 4)
            VStack(alignment: .leading, spacing: 5){
                Text(place.name)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Text(place.description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .foregroundColor(.secondary)
                
                HStack{
                    RankingView(name: "", rankingCount: place.ranking, filledImageName: "star.fill", emptyImageName: "star", filledImageColor: Color.yellow, emptyImageColor: Color.gray, iconsFrameWidth: 10)
                }
            }
        }
    }
}


struct ListItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ListViewCell(place: Place(id: "0", name: "Titel of Something", description: "Some Info about Something as multiline Text",  categorie: 1, ranking: 3, lat: 55.5555, lon: 10.1010, img: "someimage", uiimage: ImageLoader().loadImageFromURL(str: "\(ConectData().testImageUrl)")))
    }
}

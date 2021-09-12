//
//  RankingView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct RankingView: View {
    var name:String
    var rankingCount: Int
    var filledImageName:String
    var emptyImageName:String
    var filledImageColor: Color
    var emptyImageColor: Color
    var iconsFrameWidth: Int
    
    var body: some View {
        HStack{
            Text(name)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .minimumScaleFactor(0.7)

            ForEach(0..<5){ count in
                
                if(rankingCount > count){
                    Image(systemName: filledImageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(filledImageColor)
                        .frame(width: CGFloat(iconsFrameWidth), alignment: .center)
                }else{
                    Image(systemName: emptyImageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(emptyImageColor)
                        .frame(width: CGFloat(iconsFrameWidth), alignment: .center)
                }
            }
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(name: "Ranking:", rankingCount: 2, filledImageName: "star.fill", emptyImageName: "star", filledImageColor: .yellow, emptyImageColor: .yellow, iconsFrameWidth: 10)
    }
}

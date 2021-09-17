//
//  RankingFilterView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct RankingFilterView: View {
    @Binding var rankingChoice: Ranking
    
    var body: some View {
        HStack{
            Text("Ranking:").bold().padding(.trailing, 10)
            
            ImageRankingButton(number: 1, rankingChoice: $rankingChoice)
            ImageRankingButton(number: 2, rankingChoice: $rankingChoice)
            ImageRankingButton(number: 3, rankingChoice: $rankingChoice)
            ImageRankingButton(number: 4, rankingChoice: $rankingChoice)
            ImageRankingButton(number: 5, rankingChoice: $rankingChoice)
            
            VStack(spacing: 1){
                Text("All")
                    .minimumScaleFactor(0.2)
                Button(action: {
                    print("all")
                    if(rankingChoice.allIsTrue()){
                        rankingChoice = Ranking(one: false, two: false, three: false, four: false, five: false)
                    }else{
                        rankingChoice = Ranking(one: true, two: true, three: true, four: true, five: true)
                    }
                    
                }, label: {
                    SelectImageRanking(selector: rankingChoice.allIsTrue())
                }).frame(height: 20)
            }.padding(.leading, 20)
            
        }
    }
}

struct ImageRankingButton: View{
    @State var number: Int
    @Binding var rankingChoice: Ranking
    var body: some View{
        
        VStack(spacing: 1){
            Text("\(number)")
                .minimumScaleFactor(0.2)
            Button(action: {
                if(number == 1){
                    self.rankingChoice.one.toggle()
                }else if(number == 2){
                    self.rankingChoice.two.toggle()
                }else if(number == 3){
                    self.rankingChoice.three.toggle()
                }else if(number == 4){
                    self.rankingChoice.four.toggle()
                }else if(number == 5){
                    self.rankingChoice.five.toggle()
                }
            }, label: {
                
                if(number == 1){
                    SelectImageRanking(selector: rankingChoice.one)
                }else if(number == 2){
                    SelectImageRanking(selector: rankingChoice.two)
                }else if(number == 3){
                    SelectImageRanking(selector: rankingChoice.three)
                }else if(number == 4){
                    SelectImageRanking(selector: rankingChoice.four)
                }else if(number == 5){
                    SelectImageRanking(selector: rankingChoice.five)
                }
                
            }).frame(height: 20)
        }
    }
}

struct SelectImageRanking: View{
    var selector: Bool
    var body: some View{
        if(selector){
            ImageRanking(imgName: "star.fill", imgColor: .yellow)
        }else{
            ImageRanking(imgName: "star", imgColor: .gray)
        }
    }
}

struct ImageRanking: View{
    @State var imgName: String
    @State var imgColor: Color
    var body: some View{
        Image(systemName: imgName)
            .resizable()
            .scaledToFit()
            .foregroundColor(imgColor)
    }
}

struct RankingFilterView_Previews: PreviewProvider {
    @State static var rankingChoice = Ranking(one: true, two: true, three: true, four: true, five: true)
    static var previews: some View {
        RankingFilterView(rankingChoice: $rankingChoice)
    }
}

//
//  FiltersView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct FiltersView: View {
    @Binding var rankingChoice: Ranking
    @Binding var isFilterActive: Bool
    @Binding var isSearchActive: Bool
    @Binding var searchText: String
    
    var body: some View {
        if(isFilterActive){
            RankingFilterView(rankingChoice: $rankingChoice)
                .padding(.horizontal, 8)
                .transition(.move(edge: .trailing))
                .animation(.linear)
        }
        if(isSearchActive){
            SearchView(searchText: $searchText)
                .padding(.horizontal, 8)
                .transition(.move(edge: .trailing))
                .animation(.linear)
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    @State static var rankingChoice: Ranking = Ranking(one: true, two: true, three: true, four: true, five: true)
    @State static var isFilterActive: Bool = false
    @State static var isSearchActive: Bool = false
    @State static var searchText: String = ""
    
    static var previews: some View {
        FiltersView(rankingChoice: $rankingChoice, isFilterActive: $isFilterActive, isSearchActive: $isSearchActive, searchText: $searchText)
    }
}

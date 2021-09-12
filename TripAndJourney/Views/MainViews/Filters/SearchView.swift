//
//  SearchView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct SearchView: View{
    @Binding var searchText: String
    var body: some View{
        HStack{
            TextField("Search ...", text: $searchText )
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.leading, 8)
                .transition(.move(edge: .trailing))
                .animation(.linear)
           
            Button(action: {
                if(searchText != ""){
                    searchText = ""
                }
            }, label: {
                Text("Clear")
            }).padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.linear)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var searchText: String = ""

    static var previews: some View {
        SearchView(searchText: $searchText)
    }
}

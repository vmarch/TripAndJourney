//
//  SearchView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct SearchView: View{
    @EnvironmentObject var dc:DataController
    var body: some View{
        HStack{
            TextField("Search ...", text: $dc.searchText )
                .modifier(SearchClearButton( myPadding: EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 8)))
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.leading, 8)
                .transition(.move(edge: .trailing))
                .animation(.linear)
           
            Button(action: {
                dc.isSearchActive = false
            }, label: {
                Text("Cancel")
            }).padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.linear)
        }.frame(height: 44)
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var searchText: String = ""

    static var previews: some View {
        SearchView()
    }
}

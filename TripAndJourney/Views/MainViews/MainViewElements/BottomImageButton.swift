//
//  BottomImageButton.swift
//  TripAndJourney
//
//  Created by Student on 17.09.21.
//

import SwiftUI
struct BottomImageButton: View{
    var imageSystemName:String
    var iconColor: Color
    var body: some View {
        Image(systemName: imageSystemName)
            .resizable()
            .scaledToFit()
            .foregroundColor(iconColor)
            .frame(height: 20)
    }
}

struct BottomImageButton_Previews: PreviewProvider {
    static var previews: some View {
        BottomImageButton(imageSystemName: "map",iconColor: .blue)
    }
}




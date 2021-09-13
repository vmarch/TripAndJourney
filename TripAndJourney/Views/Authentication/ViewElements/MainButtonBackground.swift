//
//  MainActionButton.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct MainButtonBackground: View {
    var title:String
    var body: some View {
        Text(title)
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.white)
            .foregroundColor(.black)
            .font(.system(size: 32, weight: .medium))
            .cornerRadius(15)
            .padding()
    }
}

struct MainButtonBackground_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonBackground(title: "")
    }
}

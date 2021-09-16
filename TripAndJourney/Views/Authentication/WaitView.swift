//
//  WaitView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct WaitView: View{
        
    var body: some View{
        Text("Waiting for the response from server...").frame(width: 200, height: 500, alignment: .center).multilineTextAlignment(TextAlignment.center)
            .foregroundColor(.white)
            .font(.system(size: 28, weight: .medium))
            .shadow(radius: 5)
            .padding()
    }
}
struct WaitView_Previews: PreviewProvider {
    static var previews: some View {
        WaitView()
    }
}

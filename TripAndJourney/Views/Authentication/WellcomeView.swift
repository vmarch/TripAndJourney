//
//  WellcomeView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct WellcomeView: View{
        
    var body: some View{
        Text("Wellcome").frame(width: 200, height: 50, alignment: .center)
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .medium))
            .padding()
    }
}

struct WellcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WellcomeView()
    }
}


//
//  TripAndJourneyApp.swift
//  TripAndJourney
//
//  Created by Student on 12.09.21.
//

import SwiftUI

@main
struct TripAndJourneyApp: App {
    @StateObject var dc: DataController = DataController()
   
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }.environmentObject(dc)
        }
    }
}

//
//  Place.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import Foundation
import SwiftUI
struct Place: Identifiable{
    let cid = UUID()
    
    var id, name, description: String
    let categorie, ranking: Int
    let lat, lon: Double
    let img: String
    var uiimage: UIImage
    
    func getCategorieAsString() ->String{
      
        if(categorie == 0){
            return "Market"
        }else if(categorie == 1){
            return "Restaurant"
        }else if(categorie == 2){
            return "FastFood"
        }else if(categorie == 3){
            return "Supermarket"
        }else if(categorie == 4){
            return "Cafe"
        }else{
            return "Another"
        }
    }
}

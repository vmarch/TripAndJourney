//
//  Ranking.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import Foundation
struct Ranking{
    var one, two, three, four, five: Bool
    
    func allIsTrue() -> Bool{
        if(one && two && three && four && five){
            return true
        }else{
            return false
        }
    }
    
    func allIsFalse() -> Bool{
        if(!one && !two && !three && !four && !five){
            return true
        }else{
            return false
        }
    }
}


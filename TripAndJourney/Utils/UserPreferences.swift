//
//  UserPreferences.swift
//  TripAndJourney
//
//  Created by devtolife on 13.09.21.
//

import Foundation
class UserPreferences{
    
    private let pref: UserDefaults = UserDefaults.standard
    init(){
        
    }
    
    func saveLocalUserTokenIfLogged(userToken: String){
        pref.set(userToken, forKey: "usertoken")
    }
    
    func getLocalUserTokenIfLogged() -> String{
        pref.object(forKey: "usertoken") as? String ?? ""
    }
}

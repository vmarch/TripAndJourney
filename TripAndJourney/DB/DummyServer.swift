//
//  DummyServer.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import Foundation

class DummyServer{
    
    //Server responce emulation
    var isLogged:Bool = false
    var authResponce:Bool = false
    
    init(){
        print("SomeServer is initialised.")
    }
    
    func checkIfUserIsLogged() -> Bool{
        print("in server checking")
        return isLogged
    }
    
    func login(login:String, password:String) ->Bool{
        print("in server login")
        return authResponce
    }
    
    func register(login:String, password:String) ->Bool{
        print("in server register")
        return authResponce
    }
}


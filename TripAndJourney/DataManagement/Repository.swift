//
//  Repository.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import Foundation
class Repository{
    private var server: DummyServer = DummyServer()
    private var isInternet: Bool = true
    
    var userLoggedIn: Bool = false
    
    var dataController:DataController? = nil
    
    init(){}
    
    //Check on Server if User is logged
    //For testing user's token == id in Server DB Table
    func checkOnServerIfCurrentUserIsLogged(dc:DataController, userToken: String){
     dataController = dc

        if(!isInternet){
            print("Show allert = No Internet")
        }else{
            let url = URL(string: (ConectData().testIsLoggedEndpoint))!
            let bodyData: String = "uid=\(userToken)"
            NetworkService.connectToServer(url: url, bodyDataText: bodyData) {  [weak self] resultData, resultError in
                guard let self = self else{return}
                if(resultData != nil){
                   
                    do {
                        guard let d = resultData else {return}
                            let decodedJson = try JSONDecoder().decode([IsLoggedResponseData].self, from: d)
                    
                            DispatchQueue.main.async {
                                guard let dataController = self.dataController else { return }
                                dataController.isStayLoggedInApp(data: decodedJson[0])
                            }
                            //If on server User status is not logged -> delete current user token in app.
                            if(decodedJson[0].state == "2"||decodedJson[0].state == "0"){
                                self.deleteUserTokenInApp()
                            }
                            
                    }catch{
                        print("ERROR")
                        self.dataController = nil
                    }
                }else{
                    print("ERROR: \(String(describing: resultError))")
                    self.dataController = nil
                }
            }
        }
    }
    
    //Check if some Token is saved in App.
    func checkUserTokenInApp() -> String{
        return UserPreferences().getUserTokenSavedInApp()
    }
    
    //Save User's Token in App
    func saveUserTokenInApp(userToken: String){
        UserPreferences().setUserTokenInApp(userToken: userToken)
    }
    
    private func deleteUserTokenInApp() {
        //Clear User Token which was saved in app.
        UserPreferences().clearUserTokenSavedInApp()
    }
    
    //Authenticate with LoginName and Password
    func login(dc: DataController, signInData:SignInData){
     
     dataController = dc
        
        if(!isInternet){
            userLoggedIn = server.login(login: signInData.username, password: signInData.password)
        }else{
            let url = URL(string: (ConectData().testLogintEndpoint))!
            let bodyData: String = "username=\(signInData.username)&password=\(signInData.password)"
            NetworkService.connectToServer(url: url, bodyDataText: bodyData) {  [weak self] resultData, resultError in
                guard let self = self else{return}
                if(resultData != nil){
                   
                    do {
                        guard let d = resultData else {return}
                            let decodedJson = try JSONDecoder().decode([LoginResponseData].self, from: d)
                    
                            DispatchQueue.main.async {
                                guard let dataController = self.dataController else { return }
                                dataController.isLoggedIn(data: decodedJson[0])
                            }
                            //Change user login status on server if user logged in.
                            if(decodedJson[0].state == "3"){
                                self.changeUserLoginStatusOnServer(userToken:decodedJson[0].uid,changeStatusTo: true)
                            }
                    }catch{
                        print("ERROR")
                        self.dataController = nil
                    }
                }else{
                    print("ERROR: \(String(describing: resultError))")
                    self.dataController = nil
                }
            }
        }
    }
    
    //Register with LoginName and Password
    func register(dc: DataController, signUpData: SignUpData){
        dataController = dc
        
        if(!isInternet){
            userLoggedIn = server.register(login: signUpData.email, password: signUpData.password)
        }else{
            
            let url = URL(string: (ConectData().testRegisterEndpoint))!
            let bodyData: String = "username=\(signUpData.email)&password=\(signUpData.password)&email=\(signUpData.email)"
            NetworkService.connectToServer(url: url, bodyDataText: bodyData) {  [weak self] resultData, resultError in
                guard let self = self else{return}
                if(resultData != nil){
                   
                    do {
                        guard let d = resultData else {return}
                            let decodedJson = try JSONDecoder().decode([RegisterResponseData].self, from: d)
                        
                            DispatchQueue.main.async {
                                guard let dataController = self.dataController else { return }
                                dataController.isPreRegistered(data: decodedJson[0])
                            }
                            //If on server User status is not logged -> delete current user token in app.
                            if(decodedJson[0].state == "2"||decodedJson[0].state == "0"){
                                self.deleteUserTokenInApp()
                            }
                            
                    }catch{
                        print("ERROR")
                        self.dataController = nil
                    }
                }else{
                    print("ERROR: \(String(describing: resultError))")
                    self.dataController = nil
                }
            }
        }
    }
    
    //Change User's login status on server.
    //For testing user's "token" == "id" of user in Server Table
    private func changeUserLoginStatusOnServer(userToken: String, changeStatusTo:Bool){
        
        if(!isInternet){
            print("Show allert = NO INTERNET")
        }else{
            let url = URL(string: (ConectData().testChangeUserLoginStatusEndpoint))!
            var status: String
            if(changeStatusTo){
                status = "1"
            }else{
                status = "0"
            }
            let bodyData: String = "uid=\(userToken)&status=\(status)"
            NetworkService.connectToServer(url: url, bodyDataText: bodyData) {  [weak self] resultData, resultError in
                guard let self = self else{return}
                if(resultData != nil){
                   
                    do {
                        guard let d = resultData else {return}
                            let decodedJson = try JSONDecoder().decode([LoginStatusResponseData].self, from: d)
                        
//                            DispatchQueue.main.async {
//                                guard let dataController = self.dataController else { return }
//                                dataController.isPreRegistered(data: decodedJson[0])
//                            }
                      
                            
                    }catch{
                        print("ERROR")
                        self.dataController = nil
                    }
                }else{
                    print("ERROR: \(String(describing: resultError))")
                    self.dataController = nil
                }
            }
        }
    }
    
    //Logout from Server and App.
    //For testing user's token == id in Server DB Table
    func logout(){
        changeUserLoginStatusOnServer(userToken:checkUserTokenInApp(),changeStatusTo: false)
        deleteUserTokenInApp()
    }
}

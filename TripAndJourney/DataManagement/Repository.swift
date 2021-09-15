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
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyData: String = "uid=\(userToken)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ [weak self]
                (data, response, error) in
                guard let self = self else{return}
                do {
                    if let d = data {
                        let decodedJson = try JSONDecoder().decode([IsLoggedResponseData].self, from: d)

                        DispatchQueue.main.async {
                            self.dataController!.isStayLoggedInApp(data: decodedJson[0])
                        }
                        //If on server User status is not logged -> delete current user token in app.
                        if(decodedJson[0].state == "2"||decodedJson[0].state == "0"){
                            self.deleteUserTokenInApp()
                        }
                        
                    } else {
                        print("NO DATA1 \(String(describing: data))")
                        print("NO DATA2 \(String(describing: response))")
                        print("NO DATA3 \(String(describing: error))")
                        self.dataController = nil
                    }
                }catch{
                    print("ERROR")
                    self.dataController = nil
                }
            }
            dataTask.resume()
            
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
     
        self.dataController = dc
        
        if(!isInternet){
            userLoggedIn = server.login(login: signInData.username, password: signInData.password)
        }else{
            let url = URL(string: (ConectData().testLogintEndpoint))!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyData: String = "username=\(signInData.username)&password=\(signInData.password)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ [weak self]
                (data, response, error) in
                guard let self = self else{return}
                do {
                    if let d = data {
                        
                        let decodedJson = try JSONDecoder().decode([LoginResponseData].self, from: d)
                       
                        DispatchQueue.main.async {
                            self.dataController!.isLoggedIn(data: decodedJson[0])
                        }
                        //Change user login status on server if user logged in.
                        if(decodedJson[0].state == "3"){
                            self.changeUserLoginStatusOnServer(userToken:decodedJson[0].uid,changeStatusTo: true)
                        }
                        
                    } else {
                        print("NO DATA1 \(String(describing: data))")
                        print("NO DATA2 \(String(describing: response))")
                        print("NO DATA3 \(String(describing: error))")
                        self.dataController = nil
                    }
                }catch{
                    print("ERROR")
                   
                    self.dataController = nil
                }
            }
            dataTask.resume()
        }
    }
    
    //Register with LoginName and Password
    func register(dc: DataController, signUpData: SignUpData){
        self.dataController = dc
        
        if(!isInternet){
            userLoggedIn = server.register(login: signUpData.email, password: signUpData.password)
        }else{
            let url = URL(string: (ConectData().testRegisterEndpoint))!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyData: String = "username=\(signUpData.email)&password=\(signUpData.password)&email=\(signUpData.email)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ [weak self]
                (data, response, error) in
                guard let self = self else{return}
                do {
                    if let d = data {
                        let decodedJson = try JSONDecoder().decode([RegisterResponseData].self, from: d)
                        guard let dataController = self.dataController else { return }

                        DispatchQueue.main.async {

                           dataController.isPreRegistered(data: decodedJson[0])
                        }
                        
                    } else {
                        print("NO DATA1 \(String(describing: data))")
                        print("NO DATA2 \(String(describing: response))")
                        print("NO DATA3 \(String(describing: error))")
                        self.dataController = nil
                    }
                }catch{
                    print("ERROR")
                    self.dataController = nil
                }
            }
            dataTask.resume()
        }
    }
    
    //Change User's login status on server.
    //For testing user's "token" == "id" of user in Server Table
    private func changeUserLoginStatusOnServer(userToken: String, changeStatusTo:Bool){
        
        if(!isInternet){
            print("Show allert = NO INTERNET")
        }else{
            let url = URL(string: (ConectData().testChangeUserLoginStatusEndpoint))!

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            var status: String
            if(changeStatusTo){
                status = "1"
            }else{
                status = "0"
            }
            let bodyData: String = "uid=\(userToken)&status=\(status)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ //[weak self]
                (data, response, error) in
             //   guard let self = self else{return}
                do {
                    if let d = data {

                        let decodedJson = try JSONDecoder().decode([LoginStatusResponseData].self, from: d)
                        //  DispatchQueue.main.async {
                        //      self.dc?.isStayLoggedInApp(data: decodedJson[0])
                        //  }
                    } else {
                        print("NO DATA1 \(String(describing: data))")
                        print("NO DATA2 \(String(describing: response))")
                        print("NO DATA3 \(String(describing: error))")
                    }
                }catch{
                    print("ERROR")
                }
            }
            dataTask.resume()
        }
    }
    
    //Logout from Server and App.
    //For testing user's token == id in Server DB Table
    func logout(){
        changeUserLoginStatusOnServer(userToken:checkUserTokenInApp(),changeStatusTo: false)
        deleteUserTokenInApp()
    }
}

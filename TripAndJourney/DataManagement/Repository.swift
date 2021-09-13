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
    
    var loadIsFinished: Bool = false
    var dc:DataController? = nil
    //  private var loginData: LoginData = LoginData(state: "", txt: "", uid: "")
    private var loginResponseData: [LoginResponseData] = []
    
    init(){
        
    }
    
    func saveLocalUserLoginToken(userToken: String){
        UserPreferences().saveLocalUserTokenIfLogged(userToken: userToken)
    }
    
    func getLocalUserLoginToken() -> String{
        return UserPreferences().getLocalUserTokenIfLogged()
    }
    
    //Authenticate with LoginName and Password
    func login(dc: DataController, signInData:SignInData){
        self.dc = dc
        if(!isInternet){
            userLoggedIn = server.login(login: signInData.username, password: signInData.password)
        }else{
            
            print ("<<<<< Repository >>>>> login: \(signInData.username), password: \(signInData.password)")
            let url = URL(string: (ConectData().testLogintEndpoint))!
            
            print ("<<<<< Repository >>>>> URL: \(url)")
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyData: String = "username=\(signInData.username)&password=\(signInData.password)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ [self]
                
                (data, response, error) in
                
                print (data!)
                print(String(data: data!,encoding: .utf8)!)
                
                do {
                    if let d = data {
                        
                        let decodedJson = try JSONDecoder().decode([LoginResponseData].self, from: d)
                        
                        print("decodedJson: \(decodedJson)")
                        print("\(dc)")
                        // self.dc?.isLoggedIn(data: decodedJson[0])
                        
                        
                        DispatchQueue.main.async {
                            self.dc?.isLoggedIn(data: decodedJson[0])
                        }
                        
                    } else {
                        print("NO DATA")
                        self.dc = nil
                    }
                }catch{
                    print("ERROR")
                    self.dc = nil
                }
            }
            dataTask.resume()
        }
    }
    
    //Register with LoginName and Password
    func register(dc: DataController, signUpData: SignUpData){
        self.dc = dc
        if(!isInternet){
            userLoggedIn = server.register(login: signUpData.email, password: signUpData.password)
        }else{
            print ("<<<<< Repository >>>>> login: \(signUpData.email), password: \(signUpData.password)")
            let url = URL(string: (ConectData().testRegisterEndpoint))!
            
            print ("<<<<< Repository >>>>> URL: \(url)")
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyData: String = "username=\(signUpData.email)&password=\(signUpData.password)&email=\(signUpData.email)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ [self]
                (data, response, error) in
                
                print (data!)
                print("<<<<< Repository >>>>> in dataTask \(String(data: data!,encoding: .utf8)!)")
                
                do {
                    if let d = data {
                        print("<<<<< Repository >>>>> in dataTask \(d)")
                        let decodedJson = try JSONDecoder().decode([RegisterResponseData].self, from: d)
                        
                        print("decodedJson: \(decodedJson)")
                        print("\(dc)")
                        // self.dc?.isLoggedIn(data: decodedJson[0])
                        
                        DispatchQueue.main.async {
                            self.dc?.isPreRegistered(data: decodedJson[0])
                        }
                        
                    } else {
                        print("NO DATA")
                        self.dc = nil
                    }
                }catch{
                    print("ERROR")
                    self.dc = nil
                }
            }
            dataTask.resume()
        }
    }
    
    //Check on Server/FireBase/DB if User logged
    //For testing user's token == id in Server DB Table
    func checkIfUserIsLogged(dc:DataController, userToken: String){
        self.dc = dc
        if(!isInternet){
            userLoggedIn = server.checkIfUserIsLogged()
        }else{
            print ("<<<<< Repository >>>>> uid: \(userToken)")
            
            let url = URL(string: (ConectData().testIsLoggedEndpoint))!
            
            print ("<<<<< Repository >>>>> URL: \(url)")
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyData: String = "uid=\(userToken)"
            request.httpBody = bodyData.data(using: .utf8)
            
            let dataTask = URLSession.shared.dataTask(with: request){ [self]
                (data, response, error) in
                
                print (data!)
                print("<<<<< Repository >>>>> in dataTask \(String(data: data!,encoding: .utf8)!)")
                
                do {
                    if let d = data {
                        print("<<<<< Repository >>>>> in dataTask \(d)")
                        let decodedJson = try JSONDecoder().decode([IsLoggedResponseData].self, from: d)
                        
                        print("decodedJson: \(decodedJson)")
                        print("\(dc)")
                        
                        DispatchQueue.main.async {
                            self.dc?.stayLoggedInApp(data: decodedJson[0])
                        }
                        
                    } else {
                        print("NO DATA")
                        self.dc = nil
                    }
                }catch{
                    self.dc = nil
                    print("ERROR")
                }
            }
            dataTask.resume()
            
        }
    }
    
}

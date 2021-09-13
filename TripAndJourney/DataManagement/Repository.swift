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
    
//    init(dc:DataController){
//        self.dc = dc
//    }
    
    
    //Authenticate with LoginName and Password
    func login(dc: DataController, signInData:SignInData){
        self.dc = dc
        if(!isInternet){
            userLoggedIn = server.login(login: signInData.email, password: signInData.password)
        }else{
          
            print ("<<<<< Repository >>>>> login: \(signInData.email), password: \(signInData.password)")
            let url = URL(string: "\(ConectData().testLogintEndpoint)?u=\(signInData.email)&p=\(signInData.password)")!
           
            print ("<<<<< Repository >>>>> URL: \(url)")
            let dataTask = URLSession.shared.dataTask(with: url){ [self]
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
                    }
                }catch{
                    print("ERROR")
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
               
                print ("<<<<< Repository >>>>> in dataTask")
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
                    }
                }catch{
                    print("ERROR")
                }
            }
            dataTask.resume()
        }
    }
    
    //Check on Server/FireBase/DB if User logged
    func checkIfUserIsLogged(dc:DataController){
        self.dc = dc
        if(!isInternet){
            userLoggedIn = server.checkIfUserIsLogged()
        }else{
            // self.dc?.isRegistered(data: decodedJson[0])
            // TODO CREATE CHECKING IF USER STAY LOGED IN APP!!!!
        }
    }
}

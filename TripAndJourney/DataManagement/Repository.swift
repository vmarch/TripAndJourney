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
//                            self.loginData = decodedJson
//                            //    print(self.loginData)
//                            //    print(self.loginData[0])
//                            if(self.loginData[0].state == "3"){
//                                self.userLoggedIn = true
//                                print(self.loginData)
//                            }else if(self.loginData[0].state == "2"){
//                                self.userLoggedIn = false
//                                print(self.loginData)
//                            }else if(self.loginData[0].state == "1"){
//                                self.userLoggedIn = false
//                                print(self.loginData)
//                            }
//
//                            self.loadIsFinished = true
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
            // self.dc?.isRegistered(data: decodedJson[0])
            // TODO CREATE REGISTER!!!!
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

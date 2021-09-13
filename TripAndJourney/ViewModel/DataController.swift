//
//  DataController.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import MapKit
import SwiftUI

final class DataController: ObservableObject{
    
    private var repository: Repository = Repository()
    
    @Published var viewSelector:ViewSelector = .start
    
    @StateObject private var userLocationManager = UserLocationManager()
    
    @Published var userIsLoggedIn: Bool = false
    
    
    @Published var signInData: SignInData = SignInData(email: "", password: "")
    @Published var signUpData: SignUpData = SignUpData(firstName: "", lastName: "", nick: "" , age: 0 , city: "", email: "", password: "")
    
    private var aData: [Place] = []
    @Published var aDataFilteredList: [Place] = []
    
    @Published var rankingChoice: Ranking = Ranking(one: true, two: true, three: true, four: true, five: true)
    @Published var isFilterActive: Bool = false
    @Published var isSearchActive: Bool = false
    @Published var searchText: String = ""
    
    @Published var lookingAs = LookingAs.list
    
    // private var currentUserLocation: CLLocation
    
    
    func getCurrentUserLocation(){
        userLocationManager.checkIfLocationServicesIsEnabled()
        
    }
    
    func loadData(){
        
        let imgl:ImageLoader = ImageLoader()
        
        aData = []
        aData.append(Place(id: "0", name: "A Altonaer Fischmarkt Y1", description: "Der Altonaer Fischmarkt ist ein öffentlicher Markt im Hamburger Stadtteil Altona-Altstadt. Seine Geschichte ist in die Konkurrenz der beiden rivalisierenden Städte Altona und Hamburg eingebettet.",  categorie: 0, ranking: 0, lat: 53.546001, lon: 9.954444, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "1", name: "B Campingplatz Arendsee", description: "Campingplatz und Strand sind leider etwas in die Jahre gekommen. Allerdings zum Entspannen und für die Kinder war es ein perfekter Urlaub",  categorie: 3, ranking: 3, lat: 53.548000, lon: 9.998882, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "2", name: "C Zoo Leipzig", description: "Zoo mit Themenbereichen für 850 verschiedene Spezies in naturnahem Lebensraum und Programmen zur Arterhaltung.",  categorie: 4, ranking: 4, lat: 53.548555, lon: 9.999999, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "3", name: "D UCI Othmarschen Park", description: "Der Altonaer Fischmarkt ist ein öffentlicher Markt im Hamburger Stadtteil Altona-Altstadt. Seine Geschichte ist in die Konkurrenz der beiden rivalisierenden Städte Altona und Hamburg eingebettet.",  categorie: 0, ranking: 1, lat: 53.550000, lon: 10.100111, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "4", name: "E Campingplatz Arendsee", description: "Campingplatz und Strand sind leider etwas in die Jahre gekommen. Allerdings zum Entspannen und für die Kinder war es ein perfekter Urlaub",  categorie: 3, ranking: 5, lat: 53.552222, lon: 10.155550,img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "5", name: "F Zoo Leipzig", description: "Zoo mit Themenbereichen für 850 verschiedene Spezies in naturnahem Lebensraum und Programmen zur Arterhaltung.",  categorie: 4, ranking: 2, lat: 53.556565, lon: 10.100001,img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        aData.append(Place(id: "6", name: "G Altonaer Fischmarkt Y1", description: "Der Altonaer Fischmarkt ist ein öffentlicher Markt im Hamburger Stadtteil Altona-Altstadt. Seine Geschichte ist in die Konkurrenz der beiden rivalisierenden Städte Altona und Hamburg eingebettet.",  categorie: 0, ranking: 0, lat: 53.546001, lon: 9.927044, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "7", name: "H Campingplatz Arendsee", description: "Campingplatz und Strand sind leider etwas in die Jahre gekommen. Allerdings zum Entspannen und für die Kinder war es ein perfekter Urlaub",  categorie: 3, ranking: 3, lat: 53.560000, lon: 9.888588, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "8", name: "J Zoo Leipzig", description: "Zoo mit Themenbereichen für 850 verschiedene Spezies in naturnahem Lebensraum und Programmen zur Arterhaltung.",  categorie: 4, ranking: 4, lat: 53.561111, lon: 10.000003, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "9", name: "K Altonaer Fischmarkt Y1", description: "Der Altonaer Fischmarkt ist ein öffentlicher Markt im Hamburger Stadtteil Altona-Altstadt. Seine Geschichte ist in die Konkurrenz der beiden rivalisierenden Städte Altona und Hamburg eingebettet.",  categorie: 0, ranking: 1, lat: 53.562222, lon: 9.911111, img: "altonafm",uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "10", name: "L Campingplatz Arendsee", description: "Campingplatz und Strand sind leider etwas in die Jahre gekommen. Allerdings zum Entspannen und für die Kinder war es ein perfekter Urlaub",  categorie: 3, ranking: 5, lat: 53.562555, lon: 9.845884,img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        aData.append(Place(id: "11", name: "M Zoo Leiptsig", description: "Zoo mit Themenbereichen für 850 verschiedene Spezies in naturnahem Lebensraum und Programmen zur Arterhaltung.",  categorie: 4, ranking: 2, lat: 53.548545, lon: 9.822222, img: "altonafm", uiimage: imgl.loadImageFromURL(str: "\(ConectData().testImageUrl)")))
        
        filterData()
    }
    
    func allDataCount() -> Int{ aData.count}
    
    func filterData(){
        aDataFilteredList = aData
        
        filterByName()
        filterByRanking()
        
        print("aDataFilteredList = \(aDataFilteredList.count)")
        
    }
    
    private func filterByName() {
        
        var tempFilteredList: [Place] = []
        if(searchText.count > 0){
            for p in aDataFilteredList{
                if(p.name.lowercased().contains(searchText.lowercased())){
                    tempFilteredList.append(p)
                }
            }
        }else{
            tempFilteredList = aDataFilteredList
        }
        aDataFilteredList = tempFilteredList
    }
    
    private func filterByRanking(){
        var tempFilteredList: [Place] = []
        
        for p in aDataFilteredList{
            if(rankingChoice.allIsFalse()||rankingChoice.allIsTrue()){
                if(p.ranking == 0){
                    tempFilteredList.append(p)
                }
            }
            if(rankingChoice.one){
                if(p.ranking == 1){
                    tempFilteredList.append(p)
                }
            }
            if(rankingChoice.two){
                if(p.ranking == 2){
                    tempFilteredList.append(p)
                }
            }
            if(rankingChoice.three){
                if(p.ranking == 3){
                    tempFilteredList.append(p)
                }
            }
            if(rankingChoice.four){
                if(p.ranking == 4){
                    tempFilteredList.append(p)
                }
            }
            if(rankingChoice.five){
                if(p.ranking == 5){
                    tempFilteredList.append(p)
                }
            }
        }
        aDataFilteredList = tempFilteredList
    }
    
    // @State var signInData: SignInData = SignInData(email: "", pass: "")
    
    @State var password: String = ""
    @State var nick: String = ""
    
    init(){
        print("DataController is initialised.")
    }
    
    func deleteDcInstanceFromRepository(){
        repository.dc = nil
    }
    
    //Authenticate with LoginName and Password
    func tryLogin(){
        print ("<<<<< DC >>>>> tryLogin() -> --1-- login: \(self.signInData.email), password: \(self.signInData.password)")
        repository.login(dc: self, signInData: signInData)
    }
    
    //Register with LoginName and Password
    func tryRegister(){
        print ("<<<<< DC >>>>> register: \(signUpData.email), password: \(signUpData.password)")
        repository.register(dc:self, signUpData: signUpData)
    }
    
    //Check on Server/FireBase if User logged
    func checkOnServerIfUserIsLogged() {
        print ("<<<<< DC >>>>> check if user stay logged in App")
        repository.checkIfUserIsLogged(dc:self)
    }
    
    //Repository responds
    //Respond by login:
    //state = another value is an Error
    //state = 0 - User not exist in DB
    //state = 1 - User exist in DB but registration not confirmed by email
    //state = 2 - User exist in DB but password is not correct
    //state = 3 - User is logged
    func isLoggedIn(data: LoginResponseData){
        print("<<<<< DC >>>>> isLoggedIn() -> data: \(data)")
        if(data.state == "3"){
            self.userIsLoggedIn = true
            self.viewSelector = .main
        }else if(data.state == "2"){
            print("Show ALLERT #2")
            self.userIsLoggedIn = false
            self.viewSelector = .login
        }else if(data.state == "1"){
            print("Show ALLERT #1")
            self.userIsLoggedIn = false
            self.viewSelector = .login
        }else if(data.state == "0"){
            print("Show ALLERT #0")
            self.userIsLoggedIn = false
            self.viewSelector = .login
        }else{
            print("Show ALLERT ERROR")
            self.userIsLoggedIn = false
            self.viewSelector = .login
        }
        // repository.dc = nil
        deleteDcInstanceFromRepository()
    }
    
    
    //Respond by registration:
    //state = 0 - User alreeady exist in DB
    //state = 1 - Error
    //state = 2 - //not used
    //state = 3 - User is registered. Need confirmation by email
    func isPreRegistered(data: RegisterResponseData){
        print("<<<<< DC >>>>> isPreRegistered() -> data: \(data)")

        if(data.state == "3"){
            self.viewSelector = .login
        }else if(data.state == "1"){
            
            print("Show ALLERT #1")
            self.viewSelector = .register
        }else if(data.state == "0"){
            
            print("Show ALLERT #0")
            self.viewSelector = .login
        }else{
            print("Show ALLERT ERROR")
        }
        self.userIsLoggedIn = false
        // repository.dc = nil
        deleteDcInstanceFromRepository()
    }
    
    //TODO!!!!!!!!!! CREATE !!!!!!!!!!
    //Respond by checking if User stay still logged in App.
    func stayLoggedInApp(data: LoginResponseData){
        print("#######:\(data)")
        //repository.dc = nil
//        if(data){
//            viewSelector = .main
//        }else{
//            viewSelector = .login
//        }
    }
}


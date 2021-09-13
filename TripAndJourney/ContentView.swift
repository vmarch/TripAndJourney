//
//  ContentView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dc:DataController = DataController()
    
    @State var viewID: Int = 1
    
    var body: some View {
        
        NavigationView{
            ZStack(){
                LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                if(self.dc.viewSelector == .main){
                    
                    VStack{
                        
                        // -------------- MainViews ---------------
                        FiltersView(rankingChoice: $dc.rankingChoice.didSet(execute: { (search) in
                            self.dc.filterData()
                        }), isFilterActive: $dc.isFilterActive,
                                    isSearchActive: $dc.isSearchActive,
                                    searchText: $dc.searchText.didSet(execute: { (search) in
                            self.dc.filterData()
                        }))
                        
                        if(self.dc.lookingAs == .list){
                            ListView(listData: $dc.aDataFilteredList )
                                .onAppear{
                                    if(self.dc.allDataCount() <= 0){
                                        self.dc.loadData()
                                    }
                                }
                            
                        } else if(self.dc.lookingAs == .grid){
                            GridView(listData: $dc.aDataFilteredList )
                                .onAppear{
                                    if(self.dc.allDataCount() <= 0){
                                        self.dc.loadData()
                                    }
                                }
                            
                        } else if(self.dc.lookingAs == .map){
                            //                            MapView(listData: $dc.aDataFilteredList )
                            //                                .onAppear{
                            //                                    if(self.dc.allDataCount() <= 0){
                            //                                        self.dc.loadData()
                            //                                    }
                            //                                }
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                                self.dc.lookingAs = LookingAs.list
                            }, label: {
                                if(self.dc.lookingAs == LookingAs.list){
                                    Image(systemName: "list.bullet.rectangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.yellow)
                                        .frame(height: 16)
                                }else{
                                    Image(systemName: "list.bullet.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .frame(height: 16)
                                }
                                
                            }
                            )
                            Spacer()
                            Button(action: {
                                self.dc.lookingAs = LookingAs.grid
                            }, label: {
                                if(self.dc.lookingAs == LookingAs.grid){
                                    Image(systemName: "rectangle.grid.2x2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.yellow)
                                        .frame(height: 20)
                                }else{
                                    Image(systemName: "rectangle.grid.2x2")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .frame(height: 20)
                                }
                                
                            }
                            )
                            Spacer()
                            Button(action: {
                                self.dc.lookingAs = LookingAs.map
                            }, label: {
                                if(self.dc.lookingAs == LookingAs.map){
                                    Image(systemName: "map.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.yellow)
                                        .frame(height: 20)
                                }else{
                                    Image(systemName: "map")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .frame(height: 20)
                                }
                                
                            }
                            )
                            Spacer()
                            
                        }
                    }
                    .navigationBarTitle("Top 13 Places DE", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(trailing:
                                            HStack{
                        
                        Button(action: {
                            self.dc.isFilterActive.toggle()
                        }, label: {
                            if(self.dc.rankingChoice.allIsTrue()){
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.blue)
                                    .frame(height: 20)
                            }else{
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.yellow)
                                    .frame(height: 20)
                            }
                        }
                        )
                        Button(action: {
                            self.dc.isSearchActive.toggle()
                        }, label: {
                            if(self.dc.searchText == ""){
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.blue)
                                    .frame(height: 20)
                            }else{
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.yellow)
                                    .frame(height: 20)
                            }
                        }
                        )
                    }
                    )
                }
                
                VStack{
                    
                    if(self.dc.viewSelector == .start){
                        // -------------- HelloView --------------
                        WellcomeView().onAppear{
                            //                            self.dc.checkOnServerIfUserIsLogged()
                            //                            self.dc.viewSelector = .login
                            
                        }
                    }else if(self.dc.viewSelector == .login){
                        // ----------- SignInView --------------
                        LoginView(output: $viewID.didSet(execute: { (state) in
                            
                            if (viewID == 1) {
                                self.dc.viewSelector = .login
                            }else if(viewID == 2){
                                self.dc.viewSelector = .register
                            }else if (viewID == 3) {
                                self.dc.viewSelector = .wait
                                self.tryToLogin()
                            }
                            
                        }), signInData: $dc.signInData)
                    }else if(self.dc.viewSelector == .register){
                        // ----------- SignUpView --------------
                        RegisterView(output: $viewID.didSet(execute: { (state) in
                            if (viewID == 1) {
                                self.dc.viewSelector = .login
                            }else if(viewID == 2){
                                self.dc.viewSelector = .register
                            }else if (viewID == 3) {
                                self.dc.viewSelector = .wait
                                self.tryToRegister()
                            }
                        }), signUpData: $dc.signUpData)
                    } else if(self.dc.viewSelector == .wait){
                        // ------------ WaitView ----------------
                        WaitView()
                    }
                }
                
            }}
    }
    func tryToLogin(){
        self.dc.tryLogin()
    }
    
    func tryToRegister(){
        self.dc.tryRegister()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

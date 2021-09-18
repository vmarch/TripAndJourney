//
//  ContentView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dc:DataController
    
    @State var viewID: Int = 1
    
    var body: some View {
            ZStack(){
                LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                if(self.dc.viewSelector == .main){
                    
                    VStack{
                        
                        // -------------- MainViews ---------------
                        FiltersView(rankingChoice: $dc.rankingChoice.didSet(execute: { (search) in
                            self.dc.filterData()
                        }), isFilterActive: $dc.isFilterActive,
                                    isSearchActive: $dc.isSearchActive
                        )
                        
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
                                    BottomImageButton(imageSystemName: "list.bullet.rectangle.fill", iconColor: .yellow)
                                }else{
                                    BottomImageButton(imageSystemName: "list.bullet.rectangle", iconColor: .blue)
                                }
                                
                            }
                            )
                            Spacer()
                            Button(action: {
                                self.dc.lookingAs = LookingAs.grid
                            }, label: {
                                if(self.dc.lookingAs == LookingAs.grid){
                                    BottomImageButton(imageSystemName: "rectangle.grid.2x2.fill", iconColor: .yellow)
                                }else{
                                    BottomImageButton(imageSystemName: "rectangle.grid.2x2", iconColor: .blue)
                                }
                                
                            }
                            )
                            Spacer()
                            Button(action: {
                                self.dc.lookingAs = LookingAs.map
                            }, label: {
                                if(self.dc.lookingAs == LookingAs.map){
                                    BottomImageButton(imageSystemName: "map.fill", iconColor: .yellow)
                                }else{
                                    BottomImageButton(imageSystemName: "map", iconColor: .blue)
                                  }
                                
                            }
                            )
                            Spacer()
                            Button(action: {
                                self.dc.logOut()
                            }, label: {
                                BottomImageButton(imageSystemName: "rectangle.portrait.and.arrow.right", iconColor: .blue)
                            }
                            )
                            Spacer()
                            
                        }
                    }
                    .navigationBarTitle("Trip & Jorney", displayMode: .inline)
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
                            }
                            
                        }))
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
                
            }.alert(isPresented: $dc.showAlert) {
                Alert(title: Text("\(dc.messageTitle)"), message: Text(dc.messageText), dismissButton: .cancel())
               /*Alert(
                    title: Text("Are you sure you want to delete this?"),
                    message: Text("There is no undo"),
                    primaryButton: .destructive(Text("Delete")) {
                        self.dc.showAlert = false
                    },
                    secondaryButton: .cancel()
                )*/
            }
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
        NavigationView{
            ContentView()
        }.environmentObject(DataController())
    }
}

//
//  LoginView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//


import SwiftUI

struct LoginView: View{
    @EnvironmentObject var dc:DataController
    @Binding var output:Int
     
  //  @State var loginData:String = ""
    @State var passData:String = ""
    
    var body: some View{
        VStack{
            
            TitleNameView()
            
            LoginField()
            PasswordField(password: $passData)
            
            Button(action:{
                dc.loginButtonPressed = true
         
            }){
                //TODO change login BAckground
                //
                if(dc.isReadyToLogin){
                    
                    Text("Login")
                                       .frame(width: 200, height: 50, alignment: .center)
                                       .background(Color.blue)
                                       .foregroundColor(.black)
                                       .font(.system(size: 32, weight: .medium))
                                       .cornerRadius(15)
                                       .padding()
                }else{
                    Text("Login")
                                       .frame(width: 200, height: 50, alignment: .center)
                                       .background(Color.secondary)
                                       .foregroundColor(.black)
                                       .font(.system(size: 32, weight: .medium))
                                       .cornerRadius(15)
                                       .padding()

                }
               
              //  MainButtonBackground(title: "Login")
            }
            
            Button(action:{
                output = 2
            }){
                Text("Try Register").font(.system(size: 24, weight: .medium))
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct TitleNameView: View {
    var body: some View {
        Text("Login")
            .font(.system(size: 40, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}

struct LoginField: View {
    @EnvironmentObject var dc:DataController
   // @Binding var loginName:String
    var body: some View {
        TextField("Login:", text: $dc.loginName).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
    }
}

struct PasswordField: View {
    @Binding var password:String
    var body: some View {
        SecureField("Password:", text: $password).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2).autocapitalization(.none)
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var output:Int = 0
    static var previews: some View {
        LoginView(output: $output)
    }
}

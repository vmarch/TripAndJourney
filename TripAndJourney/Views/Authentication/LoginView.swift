//
//  LoginView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//


import SwiftUI

struct LoginView: View{
    
    @Binding var output:Int
    @Binding var signInData:SignInData
    
    @State var loginData:String = ""
    @State var passData:String = ""
    
    var body: some View{
        VStack{
            
            TitleNameView()
            
            LoginField(loginName: $loginData)
            PasswordField(password: $passData)
            
            Button(action:{
                if(!self.loginData.isEmpty && !self.passData.isEmpty){
                  
                    self.signInData.email = self.loginData
                    self.signInData.password = self.passData
                    print ("<<<<< SignInView >>>>> login: \(signInData.email), password: \(signInData.password)")
                    output = 3
                }else{
                    print("Login and Password may not be Empty")
                }
                
               
            }){
                MainButtonBackground(title: "Login")
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
    @Binding var loginName:String
    var body: some View {
        TextField("Login:", text: $loginName).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
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
    @State static var signInData: SignInData = SignInData(email: "", password: "")
    static var previews: some View {
        LoginView(output: $output, signInData: $signInData)
    }
}

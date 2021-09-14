//
//  RegisterView.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import SwiftUI

struct RegisterView: View{
    
    @Binding var output:Int
    
    @Binding var signUpData:SignUpData
    
    @State var firstNameData:String = ""
    @State var lastNameData:String = ""
    @State var nickData:String = ""
    @State var ageData:String = ""
    @State var cityData:String = ""
    @State var emailData:String = ""
    @State var passData:String = ""
    @State var passRepeatData:String = ""
    @State var termsAgreeData:Bool = false
    
    var body: some View{
        VStack{
            Section{
                Text("Registration")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.white)
                    .padding()
                
               // TextField("Firstname:", text: $firstNameData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
               // TextField("Lastname:", text: $lastNameData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
                TextField("Nick*:", text: $nickData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
              //  TextField("Age:", text: $ageData).keyboardType(.numberPad).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
              //  TextField("City:", text: $cityData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
                TextField("E-mail*:", text: $emailData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
                SecureField("Password*:", text: $passData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
                SecureField("Password repeat*:", text: $passRepeatData).autocapitalization(UITextAutocapitalizationType.none).disableAutocorrection(true).padding().frame(width: 300, height: 40).background(Color.white).cornerRadius(6).padding(2)
            }
            
            HStack{
                Link("Terms of Service.",
                     destination: URL(string: "https://www.example.com/TOS.html")!).foregroundColor(.blue)
                Toggle("I agree.",isOn: $termsAgreeData).foregroundColor(.black)
            }.padding(8)
                .frame(width: 290, height: 40)
                .background(Color.white)
                .opacity(0.5)
                .cornerRadius(8)
                .padding(16)
            
            
            
            
            Button(action:{
                if(emailData.isEmpty){
                    print("Email can not be EMPTY")
                }else if(passData == ""){
                    print("PASSWORD can not be EMPTY")
                }else if(passData.count < 6){
                    print("PASSWORD can not less as 6 symbols")
                }else if(passData != passRepeatData){
                    print("PASSWORDS are not the same.")
                }else{
                    if(termsAgreeData){
                        self.signUpData.firstName = self.firstNameData
                        self.signUpData.lastName = self.lastNameData
                        self.signUpData.nick = self.nickData
                        self.signUpData.age = Int(self.ageData) ?? 0
                        self.signUpData.city = self.cityData
                        self.signUpData.email = self.emailData
                        self.signUpData.password =  self.passData
                        
                        output = 3
                    }else{
                        print("TOGGLE IS EMPTY")
                    }
                }
            }){
                
                MainButtonBackground(title: "Register")
                
            }
            
            Button(action:{
                output = 1
            }){
                Text("Try Login")
            }
            .font(.system(size: 24, weight: .medium))
            .foregroundColor(.gray)
            .padding()
            
        }
    }
}
struct RegisterView_Previews: PreviewProvider {
    @State static var output:Int = 0
    @State static var signUpData: SignUpData = SignUpData(firstName: "", lastName: "", nick: "" , age: 0 , city: "", email: "", password: "")
    static var previews: some View {
        RegisterView(output: $output, signUpData: $signUpData)
    }
}

//TODO fix: //  self.signUpData.age = self.ageData

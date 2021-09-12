//
//  InternalUser.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//

import Foundation

class InternaUser {

    let uid, gender, title, firstname, lastname, nick, email, phone, birthday, password, city: String?
    let age: Int?

    init(uid: String?, gender: String?, title: String?, firstname: String?, lastname: String?, nick: String?, city: String?, age: Int?, email: String?, phone: String?, birthday: String?, password: String?) {
        self.uid = uid
        self.gender = gender
        self.title = title
        self.firstname = firstname
        self.lastname = lastname
        
        self.nick = nick
        self.city = city
        self.age = age
        self.email = email
        self.phone = phone
        self.birthday = birthday
        self.password = password
    }
}

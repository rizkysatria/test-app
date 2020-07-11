//
//  Profile.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation

class Profile {
    var userName: String = ""
    var photo: String = ""
    var gender: String = ""
    var phoneNumber: String = ""
    
    static func createObject(profile: Profile) -> Profile {
        let profileObject = Profile()
        profileObject.userName = profile.userName
        profileObject.photo = profile.photo
        profileObject.gender = profile.gender
        profileObject.phoneNumber = profile.phoneNumber
        return profileObject
    }
}

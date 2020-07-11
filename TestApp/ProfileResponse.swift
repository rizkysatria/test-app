//
//  ProfileResponse.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileResponse: Mappable {
    
    var userName: String = ""
    var photo: String = ""
    var gender: String = ""
    var phoneNumber: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        userName <- map["user_name"]
        photo <- map["photo_url"]
        gender <- map["gender"]
        phoneNumber <- map["phone_number"]
    }
    
    func toProfileModel() -> Profile {
        let profile = Profile()
        profile.userName = userName
        profile.photo = photo
        profile.gender = gender
        profile.phoneNumber = phoneNumber
        return profile
    }
    
}

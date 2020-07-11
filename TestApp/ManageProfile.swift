//
//  ManageProfile.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol ManageProfileProtocol {
    func getProfile() -> Single<Profile>
    func login(email: String, password: String)
}

class ManageProfile: ManageProfileProtocol {
    
    func getProfile() -> Single<Profile> {
        if let path = Bundle.main.path(forResource: "GetProfileResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let response = Mapper<ProfileResponse>().map(JSON: jsonResult as! [String: Any]) {
                    return Single.just(Profile.createObject(profile: response.toProfileModel()))
                }
            } catch {
                //handle error
            }
        }
        return Single.just(Profile())
    }
    
    func login(email: String, password: String) {
        var dictionary: [String: Any] = [String: Any]()
        dictionary["email"] = email
        dictionary["password"] = password
        UserDefaults.standard.set(dictionary, forKey: Constant.KEY_LOGIN_USER)
        
    }
    
}

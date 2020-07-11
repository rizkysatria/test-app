//
//  LoginViewParam.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel {
    
    var email = BehaviorRelay<String>(value: "")
    var pwdd = BehaviorRelay<String>(value: "")
    
    var emailErrorMessage: String {
        get {
            if email.value.isEmpty {
                return Constant.EMPTY_EMAIL_ERROR_MESSAGE
            } else if !isValidEmail(email: email.value) {
                return Constant.INVALID_EMAIL_ERROR_MESSAGE
            } else {
                return ""
            }
        }
    }
    
    var rxEventShowHideErrorEmail: PublishSubject<(Bool, String)> {
        return eventShowHideErrorEmail
    }
    
    var rxEventShowHideErrorPwdd: PublishSubject<(Bool, String)> {
        return eventShowHideErrorPwdd
    }
    
    var rxEventSuccessLogin: PublishSubject<Void> {
        return eventSuccessLogin
    }
    
    private let eventShowHideErrorEmail = PublishSubject<(Bool, String)>()
    private let eventShowHideErrorPwdd = PublishSubject<(Bool, String)>()
    private let eventSuccessLogin = PublishSubject<Void>()
    private let manageProfileProtocol: ManageProfileProtocol
    
    init(manageProfileProtocol: ManageProfileProtocol) {
        self.manageProfileProtocol = manageProfileProtocol
    }
    
    func tapLoginButton() {
        let isEmailValid = !email.value.isEmpty && isValidEmail(email: email.value)
        let isPwddValid = !pwdd.value.isEmpty
        
        if isEmailValid && isPwddValid {
            manageProfileProtocol.login(email: email.value, password: pwdd.value)
            eventSuccessLogin.onNext(())
        } else {
            eventShowHideErrorEmail.onNext((isEmailValid, emailErrorMessage))
            eventShowHideErrorPwdd.onNext((isPwddValid, Constant.EMPTY_PASWORD_ERROR_MESSAGE))
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: Constant.EMAIL_REGEX, options: .caseInsensitive) {
            return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
        }
        return false
    }
    
}

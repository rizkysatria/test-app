//
//  Swinject.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    class func setup() {
        registerStoryboards()
        registerUsecase()
        registerViewModels()
    }
    
    private class func registerStoryboards() {
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { r, c in
            c.homeViewModel = r.resolve(HomeViewModel.self)!
        }
        
        defaultContainer.storyboardInitCompleted(ProfileViewController.self) { r, c in
            c.profileViewModel = r.resolve(ProfileViewModel.self)!
        }
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { r, c in
            c.loginViewModel = r.resolve(LoginViewModel.self)!
        }
    }
    
    private class func registerViewModels() {
       defaultContainer.register(HomeViewModel.self) { r in
            HomeViewModel()
        }
        
        defaultContainer.register(LoginViewModel.self) { r in
            LoginViewModel(manageProfileProtocol: r.resolve(ManageProfileProtocol.self)!)
        }
        
        defaultContainer.register(ProfileViewModel.self) { r in
            ProfileViewModel(manageProfileProtocol: r.resolve(ManageProfileProtocol.self)!)
        }
    }
    
    private class func registerUsecase() {
        defaultContainer.register(ManageProfileProtocol.self) { r in
            ManageProfile()
        }
    }
    
}

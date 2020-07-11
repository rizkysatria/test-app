//
//  LoginViewController.swift
//  TestApp
//
//  Created by rizky satria on 10/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    static func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailInlineErrorLabel: UILabel!
    @IBOutlet weak var emailInlineErrorView: UIView!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdInlineErrorLabel: UILabel!
    @IBOutlet weak var pwdInlineErrorView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupButton()
        setupTextField()
    }
    
    private func setupViewModel() {
        loginViewModel.rxEventShowHideErrorEmail
            .subscribe(onNext: { [weak self] show, errorMessage in
                guard let weakSelf = self else { return }
                weakSelf.emailInlineErrorView.isHidden = show
                weakSelf.emailInlineErrorLabel.text = errorMessage
            }).disposed(by: disposeBag)
        
        loginViewModel.rxEventShowHideErrorPwdd
            .subscribe(onNext: { [weak self] show, errorMessage in
                guard let weakSelf = self else { return }
                weakSelf.pwdInlineErrorView.isHidden = show
                weakSelf.pwdInlineErrorLabel.text = errorMessage
            }).disposed(by: disposeBag)
        
        loginViewModel.rxEventSuccessLogin
            .subscribe(onNext: { [weak self] in
                self?.backToMainScreen()
            }).disposed(by: disposeBag)
    }
    
    private func setupTextField() {
        pwdTextField.isSecureTextEntry = true
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.email)
            .disposed(by: disposeBag)

        pwdTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.pwdd)
            .disposed(by: disposeBag)
        
    }
    
    private func setupButton() {
        loginButton.rx.tap
        .subscribe(onNext: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view.endEditing(true)
            weakSelf.loginViewModel.tapLoginButton()
        }).disposed(by: disposeBag)
    }
    
    private func backToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        (UIApplication.shared.delegate as? AppDelegate)!.setRootScreen(viewController: storyboard.instantiateViewController(withIdentifier: "MainTabbarController"))
        dismiss(animated: true, completion: nil)
    }

}

//
//  ProfileViewController.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var profileViewModel: ProfileViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        profileViewModel.viewDidLoad()
    }
    
    private func setupViewModel() {
        profileViewModel.rxEventLoadDataSuccess
            .subscribe(onNext: { [weak self] profile in
                guard let weakSelf = self else { return }
                weakSelf.setupData(profile: profile)
            }).disposed(by: disposeBag)
    }
    
    private func setupData(profile: Profile) {
        profilePictureImg.loadUrl(profile.photo)
        userNameLabel.text = profile.userName
        genderLabel.text = profile.gender
        phoneNumber.text = profile.phoneNumber
    }
    
}

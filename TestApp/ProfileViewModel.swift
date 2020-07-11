//
//  ProfileViewModel.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit
import RxSwift

class ProfileViewModel {
    
    var rxEventLoadDataSuccess: PublishSubject<Profile> {
        return eventLoadDataSuccess
    }
    
    private let eventLoadDataSuccess = PublishSubject<Profile>()
    private let manageProfileProtocol: ManageProfileProtocol
    
    private let disposeBag = DisposeBag()
    
    init(manageProfileProtocol: ManageProfileProtocol) {
        self.manageProfileProtocol = manageProfileProtocol
    }
    
    func viewDidLoad() {
        getProfile()
    }
    
    private func getProfile() {
        manageProfileProtocol.getProfile()
            .subscribe(onSuccess: { [weak self] profile in
                guard let weakSelf = self else { return }
                weakSelf.eventLoadDataSuccess.onNext(profile)
            }).disposed(by: disposeBag)
    }
    
}

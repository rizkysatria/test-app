//
//  HomeViewModel.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var rxEventOpenImageDetail: PublishSubject<Void> {
        return eventOpenImageDetail
    }
    
    let listOfImage = Constant.listOfImage
    
    private let eventOpenImageDetail = PublishSubject<Void>()
        
    init() { }
    
    func onTapCell() {
        eventOpenImageDetail.onNext(())
    }
    
}

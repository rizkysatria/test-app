//
//  HomeViewController.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeViewModel: HomeViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
    }
    
    private func setupViewModel() {
        homeViewModel.rxEventOpenImageDetail
            .subscribe(onNext: { [weak self] _ in
                self?.showImageDetail()
            }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func showImageDetail() {
        let imageDetails = ImageDetailViewController.create()
        present(imageDetails, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.listOfImage.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.loadUrl(homeViewModel.listOfImage[indexPath.section])
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeViewModel.onTapCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
}

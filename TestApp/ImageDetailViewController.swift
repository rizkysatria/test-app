//
//  ImageDetailViewController.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit
import RxSwift

class ImageDetailViewController: UIViewController {
    
    static func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "ImageDetail", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController")
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var closeButton: UIButton!
    
    private var pages = [UIViewController]()
    private var pageContainer: UIPageViewController!
    private var currentIndex: Int?
    private var pendingIndex: Int?
    private var isMoveFromSwipe = false
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllView()
        setupPageView()
        setupPageControl()
    }
    
    func setupButton() {
        view.bringSubviewToFront(closeButton)
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    private func setupPageView() {
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([pages[0]], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        view.addSubview(pageContainer.view)
    }
    
    private func loadAllView() {
        Constant.listOfImage.forEach { url in
            if let viewController = ImageDetailComponentViewController.create() as? ImageDetailComponentViewController {
                viewController.imageUrl = url
                pages.append(viewController)
            }
        }
    }
    
    private func setupPageControl() {
           view.bringSubviewToFront(pageControl)
           pageControl.numberOfPages = pages.count
           pageControl.currentPage = 0
       }
    
}

extension ImageDetailViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        if currentIndex == pages.count-1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        isMoveFromSwipe = true
        pendingIndex = pages.firstIndex(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
    
}


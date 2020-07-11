//
//  ImageDetailComponentViewController.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit

class ImageDetailComponentViewController: UIViewController {
    
    static func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "ImageDetail", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ImageDetailComponentViewController")
    }
    
    @IBOutlet weak var image: UIImageView!
    
    var imageUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageURL()
    }
    
    private func setupImageURL() {
        image.loadUrl(imageUrl)
    }
    
}

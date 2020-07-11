//
//  UIImageViewExtension.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func loadUrl(_ urlString: String, completion: ((_ image: UIImage?) -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        sd_setImage(with: url, placeholderImage: UIImage(), options: .highPriority) { image, error, _, _ -> Void in
            guard let completion = completion , error == nil else { return }
            completion(image)
        }
    }
}

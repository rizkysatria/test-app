//
//  Utility.swift
//  TestApp
//
//  Created by rizky satria on 11/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit

class Utility {
    
    class func getImageFromURL(from stringURL: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let url = URL(string: stringURL)
        URLSession.shared.dataTask(with: url!, completionHandler: completion).resume()
    }
    
    class func getScreenWidth() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.height
        }
        return UIScreen.main.bounds.width
        
    }
    
    class func getScreenHeight() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.width
        }
        return UIScreen.main.bounds.height
    }
    
}

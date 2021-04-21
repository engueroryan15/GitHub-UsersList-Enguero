//
//  UIImageView+Extensions.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView{
    
    func downloadImageUsingAF(url: String) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
//                        print(image)
                self.image = image
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}

//
//  UIImageView+PC.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit

extension UIImageView {
    func loadImage(urlString:String){

        self.image = UIImage(named: "no_photo")
        self.contentMode = .scaleAspectFit
        APIClient.shared.loadImage(urlString: urlString) { (isSuccess, result) in

            if isSuccess,
                let image = result as? UIImage {
                self.image = image
                self.contentMode = .scaleAspectFill

            } else {
                self.image = UIImage(named: "load_failed")
                self.contentMode = .scaleAspectFit
            }
        }
    }
}

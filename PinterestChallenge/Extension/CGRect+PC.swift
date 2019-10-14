//
//  CGRect+PC.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit

// MARK:- CGRect extension -
extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return self.origin.y
        }

        set {
            self.origin.y = newValue
        }
    }

    var center: CGPoint {
        return CGPoint(x: self.x + self.width / 2, y: self.y + self.height / 2)
    }
}

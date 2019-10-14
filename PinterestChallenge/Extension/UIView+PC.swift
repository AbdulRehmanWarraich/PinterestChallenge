//
//  UIView+PC.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit

extension UIView {

    /**
     Round all corners of UIView.

     - parameter radius: how much we want to round corners.
     - returns: void.
     */
    func roundAllCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

    ///Remove all subviews from a UIView.
    func removeAllSubViews() {
        self.subviews.forEach { (aView) in
            aView.removeFromSuperview()
        }
    }

    public class func fromNib() -> Self {
        return fromNib(nibName: nil)
    }

    public class func fromNib(nibName: String?) -> Self {
        func fromNibHelper<T>(nibName: String?) -> T where T : UIView {
            let bundle = Bundle(for: T.self)
            let name = nibName ?? String(describing: T.self)
            return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T ?? T()
        }
        return fromNibHelper(nibName: nibName)
    }

    /**
     Adds dropdown shadow to UIView.

     - parameter color: Used to set specific color
     - parameter opacity: used to set opacity
     - parameter offSet: used to set offset
     - parameter radius: used to set radius
     - parameter scale: used to set scale

     - returns: void.
     */
    func addDropShadowTo(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}

//
//  ActivityIndicator.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//


import UIKit

//MARK:- ActivityIndicator Class
final class ActivityIndicator {

    // MARK:- Shared Instance
    static let shared = ActivityIndicator()

    // MARK:- Properties
    private var container: UIView = UIView()
    private var loadingView: UIView = UIView()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let containerViewTag = 92119211

    private var imageView: UIImageView = UIImageView()
    private var loaderCount = 0

    // MARK:- Constructor
    private init() {

        container.tag = self.containerViewTag
        container.frame = UIScreen.main.bounds
        container.center = UIScreen.main.bounds.center
        container.backgroundColor = UIColor(white: 0.0, alpha: 0.60)

        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.roundAllCorners(radius: 10)

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
    }


    /**
     Show customized activity indicator.
     - returns: void.
     */
    func showActivityIndicator() {

        if let window = UIApplication.shared.keyWindow {

            loaderCount = loaderCount + 1

            if window.viewWithTag(self.containerViewTag) == nil {
                window.addSubview(container)
            }

            window.bringSubviewToFront(container)

            self.container.alpha = 1
            self.container.transform = .identity

            self.activityIndicator.startAnimating()
        }
    }


    /**
     Hide activity indicator.

     - parameter withAnimation: Hide with animation or not. Bydefault it's true.

     - returns: void.
     */
    func hideActivityIndicator() {

        self.loaderCount = loaderCount - 1

        if (loaderCount <= 0) {
            self.loaderCount = 0

            self.container.alpha = 0
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
        }
    }

    /**
     Hide all activity indicators.

     - returns: void.
     */
    func removeAllActivityIndicator() {

        self.loaderCount = 0
        self.hideActivityIndicator()

        UIApplication.shared.keyWindow?.subviews.forEach({ (aView) in

            // If found in window subview then remove
            if aView.tag == self.containerViewTag {

                if let activityIndicator = (aView.subviews.first ?? UIView()).subviews.first as? UIActivityIndicatorView {
                    activityIndicator.stopAnimating()
                }
                aView.removeFromSuperview()
            }
        })
    }
}

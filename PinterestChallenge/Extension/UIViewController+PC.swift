//
//  UIViewController+PC.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit

extension UIViewController {

    func showAlert(_ title: String,
                   message: String,
                   buttonTitle :String = "OK",
                   actionHandler : @escaping () -> Void = {} ) {

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in

            actionHandler()
        })

        alertViewController.addAction(OKAction)

        self.present(alertViewController, animated: true, completion: nil)
    }
}


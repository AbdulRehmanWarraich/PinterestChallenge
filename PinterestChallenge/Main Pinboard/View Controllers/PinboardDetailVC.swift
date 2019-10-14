//
//  PinboardDetailVC.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/14/19.
//

import UIKit

class PinboardDetailVC: UIViewController {

    //MARK:- Properties
    var aPinInfo :PinboardModel?

    //MARK:- IBOutlet
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var imageLikes: UILabel!

    //MARK:- Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.roundAllCorners(radius: 32)
        profileImageView.loadImage(urlString: aPinInfo?.user?.profile_image?.medium ?? "")
        imageView.loadImage(urlString: aPinInfo?.urls?.regular ?? "")
        userName.text = aPinInfo?.user?.name ?? ""
        imageLikes.text = "\(aPinInfo?.likes ?? 0) likes"


    }
}

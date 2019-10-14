//
//  PhotoCell.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    //MARK:- IBOutlet
    @IBOutlet var containerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
}

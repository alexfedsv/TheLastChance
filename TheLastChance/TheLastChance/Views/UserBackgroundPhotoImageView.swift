//
//  UserBackgroundPhotoImageView.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 09.11.2024.
//

import UIKit

class UserBackgroundPhotoImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 12, height: 12))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

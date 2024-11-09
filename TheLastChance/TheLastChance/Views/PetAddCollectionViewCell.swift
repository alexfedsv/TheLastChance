//
//  PetAddCollectionViewCell.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import UIKit

final class PetAddCollectionViewCell: UICollectionViewCell {

    static let identifier = "PetAddCollectionViewCell"
    
    private var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemTeal
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 10
        addSubview(plusImageView)
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        plusImageView.layer.cornerRadius = plusImageView.bounds.width / 2
    }
}
extension PetAddCollectionViewCell {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = true
        plusImageView.translatesAutoresizingMaskIntoConstraints = false

        plusImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        plusImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        plusImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        plusImageView.heightAnchor.constraint(equalTo: plusImageView.widthAnchor).isActive = true
    }
}


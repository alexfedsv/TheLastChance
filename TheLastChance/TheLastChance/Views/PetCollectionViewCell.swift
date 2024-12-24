//
//  PetCollectionViewCell.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import UIKit

final class PetCollectionViewCell: UICollectionViewCell {

    static let identifier = "PetCollectionViewCellCell"
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        if Bool.random() {
            imageView.image = Bool.random() ? UIImage(systemName: "lizard.circle") : UIImage(systemName: "bird.circle")
        } else {
            imageView.image = Bool.random() ? UIImage(systemName: "dog.circle") : UIImage(systemName: "cat.circle")
        }
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemTeal
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var markImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemBackground
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .systemTeal.withAlphaComponent(0.7)
        addSubview(avatarImageView)
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(markImageView)
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setup(title: String, name: String, imageData: Data?) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.nameLabel.text = name
            if let imageData = imageData {
                self.avatarImageView.image = UIImage(data: imageData)
            }
        }
    }
    func setup(isMarked: Bool) {
        markImageView.isHidden = !isMarked
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        markImageView.layer.cornerRadius = markImageView.bounds.width / 2
    }
}
extension PetCollectionViewCell {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        markImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        markImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        markImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        markImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        markImageView.heightAnchor.constraint(equalTo: markImageView.widthAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
}

//
//  ServicesCollectionViewCell.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import UIKit

final class ServicesCollectionViewCell: UICollectionViewCell {

    static let identifier = "ServicesCollectionViewCell"
    private var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .green
        addSubview(userImageView)
        addSubview(petImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setup(title: String, description: String, userImageData: Data?, petImageData: Data?) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.descriptionLabel.text = description
            if let userImageData = userImageData {
                self.userImageView.image = UIImage(data: userImageData)
            } else {
                print("[ERROR][\(#function)]: userImageData = nil")
                self.userImageView.image = nil
            }
            if let petImageData = petImageData {
                self.petImageView.image = UIImage(data: petImageData)
            } else {
                print("[ERROR][\(#function)]: petImageData = nil")
                self.petImageView.image = nil
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        petImageView.layer.cornerRadius = petImageView.bounds.width / 2
    }
}
extension ServicesCollectionViewCell {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        userImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor).isActive = true
        
        petImageView.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
        petImageView.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: -12).isActive = true
        petImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        petImageView.widthAnchor.constraint(equalTo: petImageView.heightAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
}


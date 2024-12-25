//
//  FilterCollectionViewCell.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 23.12.2024.
//

import UIKit

final class FilterCollectionViewCell: UICollectionViewCell {

    static let identifier = "FilterCollectionViewCell"
    private var isMarked: Bool = false
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .systemTeal.withAlphaComponent(0.3)
        addSubview(titleLabel)
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setup(title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
        }
    }
    func mark() -> Bool {
        isMarked = !isMarked
        backgroundColor = .systemTeal.withAlphaComponent(isMarked ? 0.7 : 0.3)
        return isMarked
    }
    func mark(isMarked: Bool) {
        self.isMarked = isMarked
        backgroundColor = .systemTeal.withAlphaComponent(isMarked ? 0.7 : 0.3)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
extension FilterCollectionViewCell {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
    }
}


//
//  SegmentedControlView.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

protocol SegmentedControlDelegate: AnyObject {
    func segmentedControleSet(role: ServiceModel.Mode)
}

final class SegmentedControlView: UIView {

    private weak var delegate: SegmentedControlDelegate?

    var role: ServiceModel.Mode = .slave
    private lazy var leftSegmentedControlButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitle("Заказчик", for: .normal)
        return button
    }()
    private lazy var rightSegmentedControlButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10.0
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitle("Исполнитель", for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(delegate: SegmentedControlDelegate) {
        self.delegate = delegate
        layer.cornerRadius = 10.0
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemTeal.cgColor
        layer.masksToBounds = true
        backgroundColor = .systemBackground
        addSubview(leftSegmentedControlButton)
        addSubview(rightSegmentedControlButton)
        leftSegmentedControlButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
        rightSegmentedControlButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
        setupByMode()
        setupConstraints()
    }
    private func setupByMode() {
        switch role {
        case .master:
            leftSegmentedControlButton.setTitleColor(.systemBackground, for: .normal)
            rightSegmentedControlButton.setTitleColor(UIColor.systemTeal, for: .normal)
            leftSegmentedControlButton.layer.backgroundColor = UIColor.systemTeal.cgColor
            rightSegmentedControlButton.layer.backgroundColor = UIColor.systemBackground.cgColor
        case .slave:
            leftSegmentedControlButton.setTitleColor(UIColor.systemTeal, for: .normal)
            rightSegmentedControlButton.setTitleColor(.systemBackground, for: .normal)
            leftSegmentedControlButton.layer.backgroundColor = UIColor.systemBackground.cgColor
            rightSegmentedControlButton.layer.backgroundColor = UIColor.systemTeal.cgColor
        }
    }
    @objc
    private func tapped(_: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        switch role {
        case .master:
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .layoutSubviews, animations: {
                self.role = .slave
                self.setupByMode()
                delegate.segmentedControleSet(role: self.role)
            })
        case .slave:
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .layoutSubviews, animations: {
                self.role = .master
                self.setupByMode()
                delegate.segmentedControleSet(role: self.role)
            })
        }
    }
}
extension SegmentedControlView {
    private func setupConstraints() {
        leftSegmentedControlButton.translatesAutoresizingMaskIntoConstraints = false
        rightSegmentedControlButton.translatesAutoresizingMaskIntoConstraints = false

        leftSegmentedControlButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftSegmentedControlButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftSegmentedControlButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftSegmentedControlButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        rightSegmentedControlButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rightSegmentedControlButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightSegmentedControlButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightSegmentedControlButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    }
}


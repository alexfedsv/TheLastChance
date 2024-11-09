//
//  SegmentedControlView.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

protocol SegmentedControlDelegate: AnyObject {
    func segmentedControleSet(mode: SegmentedControlView.Mode)
}

final class SegmentedControlView: UIView {

    private weak var delegate: SegmentedControlDelegate?

    enum Mode {
        case master
        case slave
    }
    var mode: Mode = .slave
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
    public func setup(delegate: SegmentedControlDelegate) {
        self.delegate = delegate
        layer.cornerRadius = 10.0
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.masksToBounds = true
        backgroundColor = .purple
        addSubview(leftSegmentedControlButton)
        addSubview(rightSegmentedControlButton)
        leftSegmentedControlButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
        rightSegmentedControlButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
        setupByMode()
        setupConstraints()
    }
    private func setupByMode() {
        switch mode {
        case .master:
            leftSegmentedControlButton.setTitleColor(.white, for: .normal)
            rightSegmentedControlButton.setTitleColor(.yellow, for: .normal)
            leftSegmentedControlButton.layer.backgroundColor = UIColor.green.cgColor
            rightSegmentedControlButton.layer.backgroundColor = UIColor.purple.cgColor
        case .slave:
            leftSegmentedControlButton.setTitleColor(.yellow, for: .normal)
            rightSegmentedControlButton.setTitleColor(.white, for: .normal)
            leftSegmentedControlButton.layer.backgroundColor = UIColor.purple.cgColor
            rightSegmentedControlButton.layer.backgroundColor = UIColor.green.cgColor
        }
    }
    @objc
    private func tapped(_: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        delegate.segmentedControleSet(mode: mode)
        switch mode {
        case .master:
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .layoutSubviews, animations: {
                self.mode = .slave
                self.setupByMode()
                delegate.segmentedControleSet(mode: self.mode)
            })
        case .slave:
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .layoutSubviews, animations: {
                self.mode = .slave
                self.setupByMode()
                delegate.segmentedControleSet(mode: self.mode)
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


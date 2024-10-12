//
//  NavBarView.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import UIKit

protocol NavBarViewDelegate: AnyObject {
    func navBarLeftButtonTapped()
    func navBarLeftCenterButtonTapped()
    func navBarRightCenterButtonTapped()
    func navBarRightButtonTapped()
}
protocol NavBarViewProtocol: AnyObject {
    func setup(
        delegate: NavBarViewDelegate,
        leftImage: UIImage?,
        leftCenterImage: UIImage?,
        rightCenterImage: UIImage?,
        rightImage: UIImage?)

}

final class NavBarView: UIView, NavBarViewProtocol {

    private weak var delegate: NavBarViewDelegate?
    static let viewHeight: CGFloat = 45.0

    private lazy var leftView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftButtonTapped)))
        return view
    }()
    private lazy var leftCenterView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftCenterButtonTapped)))
        return view
    }()
    private lazy var rightCenterView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightCenterButtonTapped)))
        return view
    }()
    private lazy var rightView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightButtonTapped)))
        return view
    }()
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var leftCenterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var rightCenterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leftView)
        addSubview(leftCenterView)
        addSubview(rightCenterView)
        addSubview(rightView)
        leftView.addSubview(leftImageView)
        leftCenterView.addSubview(leftCenterImageView)
        rightCenterView.addSubview(rightCenterImageView)
        rightView.addSubview(rightImageView)
        leftCenterView.addSubview(leftCenterImageView)
        rightCenterView.addSubview(rightCenterImageView)
        rightView.addSubview(rightImageView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(
        delegate: NavBarViewDelegate, leftImage: UIImage?, leftCenterImage: UIImage?, rightCenterImage: UIImage?, rightImage: UIImage?) {
        self.delegate = delegate
        leftImageView.image = leftImage
        leftCenterImageView.image = leftCenterImage
        rightCenterImageView.image = rightCenterImage
        rightImageView.image = rightImage
    }

    @objc
    private func leftButtonTapped() {
        guard let delegate = delegate else { return }
        delegate.navBarLeftButtonTapped()
    }
    @objc
    private func leftCenterButtonTapped() {
        guard let delegate = delegate else { return }
        delegate.navBarLeftCenterButtonTapped()
    }
    @objc
    private func rightCenterButtonTapped() {
        guard let delegate = delegate else { return }
        delegate.navBarRightCenterButtonTapped()
    }
    @objc
    private func rightButtonTapped() {
        guard let delegate = delegate else { return }
        delegate.navBarRightButtonTapped()
    }
}
extension NavBarView {
    private func setupConstraints() {
        [
            leftView,
            leftCenterView,
            rightCenterView,
            rightView,
            leftImageView,
            leftCenterImageView,
            rightCenterImageView,
            rightImageView
        ].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        [
            leftView,
            leftCenterView,
            rightCenterView,
            rightView
        ].forEach({ $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true })
        [
            leftView,
            leftCenterView,
            rightCenterView,
            rightView
        ].forEach({ $0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true })
        [
            leftView,
            leftCenterView,
            rightCenterView,
            rightView
        ].forEach({ $0.heightAnchor.constraint(equalToConstant: NavBarView.viewHeight).isActive = true })
        [
            leftView,
            leftCenterView,
            rightCenterView,
            rightView
        ].forEach({ $0.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true })

        leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftCenterView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        rightCenterView.leadingAnchor.constraint(equalTo: leftCenterView.trailingAnchor).isActive = true
        rightView.leadingAnchor.constraint(equalTo: rightCenterView.trailingAnchor).isActive = true

        let imageSize: CGFloat = NavBarView.viewHeight * 0.75
        [
            leftImageView,
            leftCenterImageView,
            rightCenterImageView,
            rightImageView
        ].forEach({ $0.widthAnchor.constraint(equalToConstant: imageSize).isActive = true })
        [
            leftImageView,
            leftCenterImageView,
            rightCenterImageView,
            rightImageView
        ].forEach({ $0.heightAnchor.constraint(equalToConstant: imageSize).isActive = true })

        leftImageView.centerXAnchor.constraint(equalTo: leftView.centerXAnchor, constant: 0).isActive = true
        leftCenterImageView.centerXAnchor.constraint(equalTo: leftCenterView.centerXAnchor, constant: 0).isActive = true
        rightCenterImageView.centerXAnchor.constraint(equalTo: rightCenterView.centerXAnchor, constant: 0).isActive = true
        rightImageView.centerXAnchor.constraint(equalTo: rightView.centerXAnchor, constant: 0).isActive = true

        leftImageView.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        leftCenterImageView.centerYAnchor.constraint(equalTo: leftCenterView.centerYAnchor).isActive = true
        rightCenterImageView.centerYAnchor.constraint(equalTo: rightCenterView.centerYAnchor).isActive = true
        rightImageView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true

    }
}

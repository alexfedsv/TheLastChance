//
//  AddServiceViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

final class AddServiceViewController: UIViewController {

    var userModel: UserProfileModel?
    var petModel: PetProfileModel?
    private var navBarView = NavBarView()
    private lazy var segmentedControlView = SegmentedControlView()
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var petPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "plus.circle")
        return imageView
    }()
    private lazy var separator0View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    private lazy var separator1View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    private lazy var separator2View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Заголовок:"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Описание:"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var titleTextView: UITextView = {
        let textView = UITextView()
        //textView.layer.borderColor = .
        textView.layer.borderWidth = 1.0
        textView.font = .italicSystemFont(ofSize: 16)
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.backgroundColor = .gray
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.tintColor = .white
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .default
        return textView
    }()
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        //textView.layer.borderColor = .
        textView.layer.borderWidth = 1.0
        textView.font = .italicSystemFont(ofSize: 16)
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.backgroundColor = .gray
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.tintColor = .white
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .default
        return textView
    }()
    private lazy var saveButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .blue
        return view
    }()
    private lazy var saveButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Сохранить"
        label.textColor = .white
        return label
    }()
    private var keyboardUpDownConstraints: NSLayoutConstraint = NSLayoutConstraint()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBarView)
        view.addSubview(segmentedControlView)
        view.addSubview(petPhotoImageView)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(titleLabel)
        view.addSubview(titleTextView)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(separator1View)
        view.addSubview(saveButtonView)
        saveButtonView.addSubview(saveButtonLabel)
        navBarView.setup(delegate: self, leftImage: UIImage(systemName: "chevron.backward"), leftCenterImage: nil, rightCenterImage: nil, rightImage: nil)
        view.backgroundColor = .purple
        view.addSubview(separator2View)
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        setupConstraints()
        setupData()
        setupKeyboardObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width / 2
        petPhotoImageView.layer.cornerRadius = petPhotoImageView.bounds.width / 2
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        
    }
    
    private func setupData() {
        if let petModel = petModel {
            DispatchQueue.main.async {
                if let icon = petModel.petAvatar  {
                    self.petPhotoImageView.image = UIImage(data: icon)
                } else {
                    self.petPhotoImageView.image = nil
                }
                self.titleTextView.text = petModel.typeOfAnimal
                self.descriptionTextView.text = petModel.petName
            }
        }
        guard let userModel = userModel else { return }
        DispatchQueue.main.async {
            if let icon = userModel.userImage  {
                self.userPhotoImageView.image = UIImage(data: icon)
            } else {
                self.userPhotoImageView.image = nil
            }
        }
    }
}
extension AddServiceViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == titleTextView {
            print(text)
        }
        if textView == descriptionTextView {
            print(text)
        }
    }
}
extension AddServiceViewController: NavBarViewDelegate {
    func navBarLeftButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func navBarLeftCenterButtonTapped() {
        print(#function)
    }
    func navBarRightCenterButtonTapped() {
        print(#function)
    }
    func navBarRightButtonTapped() {
        print(#function)
    }
}
extension AddServiceViewController {
    private func setupConstraints() {
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        petPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        saveButtonView.translatesAutoresizingMaskIntoConstraints = false
        saveButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navBarView.heightAnchor.constraint(equalToConstant: NavBarView.viewHeight).isActive = true
        
        segmentedControlView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 30).isActive = true
        segmentedControlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        segmentedControlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        segmentedControlView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        petPhotoImageView.topAnchor.constraint(equalTo: segmentedControlView.bottomAnchor, constant: 30).isActive = true
        petPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        petPhotoImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        petPhotoImageView.heightAnchor.constraint(equalTo: petPhotoImageView.widthAnchor).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor).isActive = true
        userPhotoImageView.leadingAnchor.constraint(equalTo: petPhotoImageView.trailingAnchor, constant: -30).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor, constant: 30).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 3).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        saveButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        saveButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        saveButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        saveButtonLabel.centerYAnchor.constraint(equalTo: saveButtonView.centerYAnchor).isActive = true
        saveButtonLabel.centerXAnchor.constraint(equalTo: saveButtonView.centerXAnchor).isActive = true
        
        
    }
}



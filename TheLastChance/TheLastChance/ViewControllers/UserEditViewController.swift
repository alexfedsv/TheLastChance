//
//  UserEditViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 16.12.2024.
//

import UIKit

final class UserEditViewController: UIViewController {

    var userModel: UserProfileModel?

    weak var userViewController: UserHostProfileViewController?
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var userProfileEditedModel: UserProfileEditedModel = UserProfileEditedModel()
    private let imagePicker = UIImagePickerController()
    enum ImageChanging {
        case userImage
        case backgroundImage
    }
    private var imageChanging: ImageChanging?
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemTeal
        return imageView
    }()
    private var userBackgroundPhotoImageView: UserBackgroundPhotoImageView = {
        let imageView = UserBackgroundPhotoImageView()
        imageView.backgroundColor = .systemTeal.withAlphaComponent(0.25)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private var backgroundPhotoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondarySystemBackground
        label.shadowColor = .systemTeal
        label.shadowOffset = .init(width: 2, height: 2)
        label.text = "Загрузить"
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        return label
    }()
    private lazy var separator0View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private lazy var separator1View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Имя пользователя:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var contactsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Контакты:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var usernameTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemTeal.cgColor
        textView.layer.borderWidth = 1.0
        textView.font = .italicSystemFont(ofSize: 16)
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.tintColor = .systemTeal
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .go
        return textView
    }()
    private lazy var contactsTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemTeal.cgColor
        textView.layer.borderWidth = 1.0
        textView.font = .italicSystemFont(ofSize: 16)
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.tintColor = .systemTeal
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .go
        return textView
    }()
    private lazy var applyChangesButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private lazy var applyChangesButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Сохранить"
        label.textColor = .white
        return label
    }()
    private var keyboardUpDownConstraints: NSLayoutConstraint = NSLayoutConstraint()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(userBackgroundPhotoImageView)
        userBackgroundPhotoImageView.addSubview(backgroundPhotoLabel)
        backgroundPhotoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeBackgroundImage)))
        userBackgroundPhotoImageView.addSubview(userPhotoImageView)
        userPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeUserImage)))
        contentView.addSubview(separator0View)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(usernameTextView)
        contentView.addSubview(contactsLabel)
        contentView.addSubview(contactsTextView)
        contentView.addSubview(separator1View)
        contentView.addSubview(applyChangesButtonView)
        applyChangesButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyChanges)))
        applyChangesButtonView.addSubview(applyChangesButtonLabel)
        view.backgroundColor = .systemBackground
        usernameTextView.delegate = self
        contactsTextView.delegate = self
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
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            if usernameTextView.isFirstResponder {
                scrollView.scrollRectToVisible(usernameTextView.frame, animated: true)
            } else if contactsTextView.isFirstResponder {
                scrollView.scrollRectToVisible(contactsTextView.frame, animated: true)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    private func setupData() {
        guard let userModel = userModel else { return }
        DispatchQueue.main.async {
            if let icon = userModel.userImage  {
                self.userPhotoImageView.image = UIImage(data: icon)
            } else {
                self.userPhotoImageView.image = UIImage(systemName: "plus.circle")
            }
            if let backgroundImage = UserHostProfileModel.shared.backgroundImage {
                self.userBackgroundPhotoImageView.image = UIImage(data: backgroundImage)
            }
            self.usernameTextView.text = userModel.username
            self.contactsTextView.text = userModel.contacts
            self.userProfileEditedModel.username = userModel.username
            self.userProfileEditedModel.contacts = userModel.contacts
            self.userProfileEditedModel.userImage = userModel.userImage
            self.userProfileEditedModel.backgroundImage = userModel.backgroundImage
        }
    }
    @objc
    private func applyChanges() {
        guard let userViewController = userViewController else { return }
        applyChangesButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.applyChangesButtonView.layer.opacity = 0.9
            self.applyChangesButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.applyChangesButtonLabel.layer.opacity = 0.9
            self.applyChangesButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.applyChangesButtonView.layer.opacity = 1
                self.applyChangesButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.applyChangesButtonLabel.layer.opacity = 1
                self.applyChangesButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                DataManager.shared.editUserProfile(model: self.userProfileEditedModel) { err in
                    DispatchQueue.main.async {
                        if err == nil {
                            userViewController.setupUser()
                        }
                        self.applyChangesButtonView.isUserInteractionEnabled = true
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    @objc
    private func changeUserImage() {
        print(#function)
        imageChanging = .userImage
        present(imagePicker, animated: true, completion: nil)
    }
    @objc
    private func changeBackgroundImage() {
        print(#function)
        imageChanging = .backgroundImage
        present(imagePicker, animated: true, completion: nil)
    }
}
extension UserEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == usernameTextView {
            userProfileEditedModel.username = text
        }
        if textView == contactsTextView {
            userProfileEditedModel.contacts = text
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
extension UserEditViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        userBackgroundPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextView.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsTextView.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        applyChangesButtonView.translatesAutoresizingMaskIntoConstraints = false
        applyChangesButtonLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        userBackgroundPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        userBackgroundPhotoImageView.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 5).isActive = true
        userBackgroundPhotoImageView.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -5).isActive = true
        userBackgroundPhotoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        backgroundPhotoLabel.trailingAnchor.constraint(equalTo: userBackgroundPhotoImageView.trailingAnchor, constant: -15).isActive = true
        backgroundPhotoLabel.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: 100).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        usernameTextView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 3).isActive = true
        usernameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        usernameTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        usernameTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        contactsLabel.topAnchor.constraint(equalTo: usernameTextView.bottomAnchor, constant: 5).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        contactsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        contactsTextView.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 3).isActive = true
        contactsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        contactsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        contactsTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: contactsTextView.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator1View.bottomAnchor.constraint(equalTo: applyChangesButtonView.topAnchor, constant: -15).isActive = true

        applyChangesButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        applyChangesButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        applyChangesButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        applyChangesButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        applyChangesButtonLabel.centerYAnchor.constraint(equalTo: applyChangesButtonView.centerYAnchor).isActive = true
        applyChangesButtonLabel.centerXAnchor.constraint(equalTo: applyChangesButtonView.centerXAnchor).isActive = true
    }
}
extension UserEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func getIcon(pickedImageEdited: UIImage) -> Data? {
        if let imageData = pickedImageEdited.jpegData(compressionQuality: 0.3) {
            let imageSize = imageData.count
            print("Размер изображения в байтах[compressionQuality: \(0.3)] = \(imageSize)")
            return imageData
        } else {
            return nil
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userModel = userModel, let imageChanging = imageChanging else {
            dismiss(animated: true, completion: nil)
            return
        }
        var iconData: Data?
        if let pickedImageEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if let data = getIcon(pickedImageEdited: pickedImageEdited) {
                iconData = data
            }
        }
        guard let iconData = iconData else {
            dismiss(animated: true, completion: nil)
            return
        }
        DispatchQueue.main.async {
            if let image = UIImage(data: iconData) {
                switch imageChanging {
                case .userImage:
                    self.userPhotoImageView.image = image
                    self.userProfileEditedModel.userImage = iconData
                case .backgroundImage:
                    self.userBackgroundPhotoImageView.image = image
                    self.userProfileEditedModel.backgroundImage = iconData
                }
            } else {
                print("ERROR[\(#function)]: Cannot converte Data to UIImage")
            }
        }
        self.imageChanging = nil
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


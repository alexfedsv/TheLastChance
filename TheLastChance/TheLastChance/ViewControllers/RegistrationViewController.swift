//
//  RegistrationViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 23.11.2024.
//

import UIKit

final class RegistrationViewController: BaseViewController {

    weak var preprofileViewControllerDelegate: PreprofileViewControllerDelegate?
    private var commandToParent: PreprofileViewController.Command = .back
    private var registrationModel: RegistrationModel = RegistrationModel()
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private let imagePicker = UIImagePickerController()
    enum ImageAdding {
        case userImage
        case backgroundImage
    }
    private var imageAdding: ImageAdding?
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .secondarySystemBackground
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
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Логин:"
        label.numberOfLines = 1
        label.textColor = .systemTeal
        return label
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Имя:"
        label.numberOfLines = 1
        label.textColor = .systemTeal
        return label
    }()
    private lazy var contactsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Контакт:"
        label.numberOfLines = 1
        label.textColor = .systemTeal
        return label
    }()
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Пароль:"
        label.numberOfLines = 1
        label.textColor = .systemTeal
        return label
    }()
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Повтор пароля:"
        label.numberOfLines = 1
        label.textColor = .systemTeal
        return label
    }()
    private lazy var loginTextView: UITextView = {
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
    private lazy var passwordTextView: UITextView = {
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
    private lazy var confirmPasswordTextView: UITextView = {
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
    private lazy var toLoginViewControllerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Уже есть аккаунт"
        label.isUserInteractionEnabled = true
        label.textColor = .systemTeal
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    private lazy var saveButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private lazy var saveButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Зарегистрироваться"
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(userBackgroundPhotoImageView)
        userBackgroundPhotoImageView.addSubview(backgroundPhotoLabel)
        backgroundPhotoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addBackgroundImage)))
        userBackgroundPhotoImageView.addSubview(userPhotoImageView)
        userPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addUserImage)))
        contentView.addSubview(separator0View)
        contentView.addSubview(loginLabel)
        contentView.addSubview(loginTextView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(usernameTextView)
        contentView.addSubview(contactsLabel)
        contentView.addSubview(contactsTextView)
        contentView.addSubview(toLoginViewControllerLabel)
        toLoginViewControllerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toLoginViewController)))
        view.addSubview(saveButtonView)
        saveButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registrate)))
        saveButtonView.addSubview(saveButtonLabel)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextView)
        contentView.addSubview(confirmPasswordLabel)
        contentView.addSubview(confirmPasswordTextView)
        contentView.addSubview(separator1View)
        loginTextView.delegate = self
        usernameTextView.delegate = self
        contactsTextView.delegate = self
        passwordTextView.delegate = self
        confirmPasswordTextView.delegate = self
        setupConstraints()
        setupKeyboardObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        guard let preprofileViewControllerDelegate = preprofileViewControllerDelegate else { return }
        preprofileViewControllerDelegate.childIsKilled(commandToParent: commandToParent)
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
            if loginTextView.isFirstResponder {
                scrollView.scrollRectToVisible(loginTextView.frame, animated: true)
            } else if usernameTextView.isFirstResponder {
                scrollView.scrollRectToVisible(usernameTextView.frame, animated: true)
            } else if contactsTextView.isFirstResponder {
                scrollView.scrollRectToVisible(contactsTextView.frame, animated: true)
            } else if passwordTextView.isFirstResponder {
                scrollView.scrollRectToVisible(passwordTextView.frame, animated: true)
            } else if confirmPasswordTextView.isFirstResponder {
                scrollView.scrollRectToVisible(confirmPasswordTextView.frame, animated: true)
           }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc
    private func addUserImage() {
        print(#function)
        imageAdding = .userImage
        present(imagePicker, animated: true, completion: nil)
    }
    @objc
    private func addBackgroundImage() {
        print(#function)
        imageAdding = .backgroundImage
        present(imagePicker, animated: true, completion: nil)
    }
    @objc
    private func registrate() {
        saveButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.saveButtonView.layer.opacity = 0.9
            self.saveButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.saveButtonLabel.layer.opacity = 0.9
            self.saveButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.saveButtonView.layer.opacity = 1
                self.saveButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.saveButtonLabel.layer.opacity = 1
                self.saveButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                if self.registrationModel.checkData() {
                    DataManager.shared.registrate(registrationModel: self.registrationModel) { err in
                        DispatchQueue.main.async {
                            self.commandToParent = .toUserProfile
                            if err == nil {
                                self.dismiss(animated: true, completion: nil)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                            self.saveButtonView.isUserInteractionEnabled = true
                        }
                    }
                } else {
                    print("[DEBUG][\(#function)]: data is incomplete")
                    self.saveButtonView.isUserInteractionEnabled = true
                }
            }
        }
    }
    @objc
    private func toLoginViewController() {
        print(#function)
        toLoginViewControllerLabel.isUserInteractionEnabled = false
        guard let delegate = preprofileViewControllerDelegate else { return }
        DispatchQueue.main.async {
            self.commandToParent = .toLogin
            self.dismiss(animated: true, completion: nil)
            self.toLoginViewControllerLabel.isUserInteractionEnabled = true
        }
    }
}
extension RegistrationViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == loginTextView {
            registrationModel.login = text
        }
        if textView == usernameTextView {
            registrationModel.username = text
        }
        if textView == contactsTextView {
            registrationModel.contacts = text
        }
        if textView == passwordTextView {
            textView.text = String(repeating: "*", count: (textView.text ?? "").count)
        }
        if textView == confirmPasswordTextView {
            textView.text = String(repeating: "*", count: (textView.text ?? "").count)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        if textView != usernameTextView {
            if text == " " && text != "" {
                return false
            }
        }
        if textView == passwordTextView {
            registrationModel.password = ((registrationModel.password) as NSString).replacingCharacters(in: range, with: text)
        } else if textView == confirmPasswordTextView {
            registrationModel.passwordConfirmation = ((registrationModel.passwordConfirmation) as NSString).replacingCharacters(in: range, with: text)
        }
        return true
    }
}
extension RegistrationViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        userBackgroundPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTextView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextView.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextView.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        toLoginViewControllerLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButtonView.translatesAutoresizingMaskIntoConstraints = false
        saveButtonLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        userBackgroundPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        userBackgroundPhotoImageView.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 5).isActive = true
        userBackgroundPhotoImageView.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -5).isActive = true
        userBackgroundPhotoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        backgroundPhotoLabel.trailingAnchor.constraint(equalTo: userBackgroundPhotoImageView.trailingAnchor, constant: -15).isActive = true
        backgroundPhotoLabel.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true

        separator0View.topAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: 15).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        loginLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        loginTextView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 3).isActive = true
        loginTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        loginTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        loginTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: loginTextView.bottomAnchor, constant: 10).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        usernameTextView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 3).isActive = true
        usernameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        usernameTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        usernameTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        contactsLabel.topAnchor.constraint(equalTo: usernameTextView.bottomAnchor, constant: 10).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        contactsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        contactsTextView.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 3).isActive = true
        contactsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        contactsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        contactsTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        passwordLabel.topAnchor.constraint(equalTo: contactsTextView.bottomAnchor, constant: 10).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        passwordTextView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 3).isActive = true
        passwordTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        passwordTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 10).isActive = true
        confirmPasswordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        confirmPasswordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        confirmPasswordTextView.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 3).isActive = true
        confirmPasswordTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        confirmPasswordTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        confirmPasswordTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        separator1View.topAnchor.constraint(equalTo: confirmPasswordTextView.bottomAnchor, constant: 25).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        toLoginViewControllerLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        toLoginViewControllerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        saveButtonView.topAnchor.constraint(equalTo: toLoginViewControllerLabel.bottomAnchor, constant: 10).isActive = true
        saveButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        saveButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        saveButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        saveButtonLabel.centerYAnchor.constraint(equalTo: saveButtonView.centerYAnchor).isActive = true
        saveButtonLabel.centerXAnchor.constraint(equalTo: saveButtonView.centerXAnchor).isActive = true
    }
}
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func getAvatarIcon(pickedImageEdited: UIImage) -> Data? {
        if let imageData = pickedImageEdited.jpegData(compressionQuality: 0.3) {
            let imageSize = imageData.count
            print("Размер изображения в байтах[compressionQuality: \(0.3)] = \(imageSize)")
            return imageData
        } else {
            return nil
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageAdding = imageAdding else {
            dismiss(animated: true, completion: nil)
            return
        }
        var iconData: Data?
        if let pickedImageEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if let data = getAvatarIcon(pickedImageEdited: pickedImageEdited) {
                iconData = data
            }
        }
        if let iconData = iconData {
            
            DispatchQueue.main.async {
                if let image = UIImage(data: iconData) {
                    switch imageAdding {
                    case .userImage:
                        self.registrationModel.userImage = iconData
                        self.userPhotoImageView.image = image
                    case .backgroundImage:
                        self.registrationModel.backgroundImage = iconData
                        self.userBackgroundPhotoImageView.image = image
                    }
                } else {
                    self.registrationModel.userImage = nil
                    print("ERROR[\(#function)]: Cannot converte Data to UIImage")
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


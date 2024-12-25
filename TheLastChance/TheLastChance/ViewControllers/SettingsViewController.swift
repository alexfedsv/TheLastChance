//
//  SettingsViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 09.12.2024.
//

import UIKit

final class SettingsViewController: BaseViewController {

    var userModel: UserProfileModel?

    weak var userViewController: UserHostProfileViewController?
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var userSettingsEditedModel: UserSettingsEditedModel = UserSettingsEditedModel()

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
    private lazy var separator2View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Новый логин:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Пароль:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var passwordNewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Новый пароль:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var passwordOnceMoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Повтор пароля:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var passwordOldLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Старый пароль:"
        label.numberOfLines = 1
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
    private lazy var passwordNewTextView: UITextView = {
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
    private lazy var passwordOnceMoreTextView: UITextView = {
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
    private lazy var passwordOldTextView: UITextView = {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(separator0View)
        
        contentView.addSubview(applyChangesButtonView)
        applyChangesButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyChanges)))
        applyChangesButtonView.addSubview(applyChangesButtonLabel)
        view.backgroundColor = .systemBackground
        contentView.addSubview(loginLabel)
        contentView.addSubview(loginTextView)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextView)
        contentView.addSubview(separator1View)
        contentView.addSubview(passwordNewLabel)
        contentView.addSubview(passwordNewTextView)
        contentView.addSubview(passwordOnceMoreLabel)
        contentView.addSubview(passwordOnceMoreTextView)
        contentView.addSubview(passwordOldLabel)
        contentView.addSubview(passwordOldTextView)
        contentView.addSubview(separator2View)
        loginTextView.delegate = self
        setupConstraints()
        setupKeyboardObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            if loginTextView.isFirstResponder {
                scrollView.scrollRectToVisible(loginTextView.frame, animated: true)
            } else if passwordTextView.isFirstResponder {
                scrollView.scrollRectToVisible(passwordTextView.frame, animated: true)
            } else if passwordNewTextView.isFirstResponder {
                scrollView.scrollRectToVisible(passwordNewTextView.frame, animated: true)
            } else if passwordOnceMoreTextView.isFirstResponder {
                scrollView.scrollRectToVisible(passwordOnceMoreTextView.frame, animated: true)
            } else if passwordOldTextView.isFirstResponder {
                scrollView.scrollRectToVisible(passwordOldTextView.frame, animated: true)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc
    private func applyChanges() {
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
                
                self.applyChangesButtonView.isUserInteractionEnabled = true
            }
        }
    }
}
extension SettingsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == loginTextView {
            userSettingsEditedModel.login = text
        } else if textView == passwordTextView {
            userSettingsEditedModel.password = text
        } else if textView == passwordNewTextView {
            userSettingsEditedModel.passwordNew = text
        } else if textView == passwordOnceMoreTextView {
            userSettingsEditedModel.passwordNewConfirmation = text
        } else if textView == passwordOldTextView {
            userSettingsEditedModel.password = text
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
extension SettingsViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        passwordNewLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordNewTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordOnceMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordOnceMoreTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordOldLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordOldTextView.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
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
        
        separator0View.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        loginLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 10).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        loginTextView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 3).isActive = true
        loginTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        loginTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        loginTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        passwordLabel.topAnchor.constraint(equalTo: loginTextView.bottomAnchor, constant: 10).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        passwordTextView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 3).isActive = true
        passwordTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        passwordTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        separator1View.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        passwordNewLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        passwordNewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordNewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        passwordNewTextView.topAnchor.constraint(equalTo: passwordNewLabel.bottomAnchor, constant: 3).isActive = true
        passwordNewTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordNewTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        passwordNewTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        passwordOnceMoreLabel.topAnchor.constraint(equalTo: passwordNewTextView.bottomAnchor, constant: 10).isActive = true
        passwordOnceMoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordOnceMoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        passwordOnceMoreTextView.topAnchor.constraint(equalTo: passwordOnceMoreLabel.bottomAnchor, constant: 3).isActive = true
        passwordOnceMoreTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordOnceMoreTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        passwordOnceMoreTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        passwordOldLabel.topAnchor.constraint(equalTo: passwordOnceMoreTextView.bottomAnchor, constant: 10).isActive = true
        passwordOldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordOldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        passwordOldTextView.topAnchor.constraint(equalTo: passwordOldLabel.bottomAnchor, constant: 3).isActive = true
        passwordOldTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        passwordOldTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        passwordOldTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        separator2View.topAnchor.constraint(equalTo: passwordOldTextView.bottomAnchor, constant: 15).isActive = true
        separator2View.bottomAnchor.constraint(equalTo: applyChangesButtonView.topAnchor, constant: -15).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        applyChangesButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        applyChangesButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        applyChangesButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        applyChangesButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        applyChangesButtonLabel.centerYAnchor.constraint(equalTo: applyChangesButtonView.centerYAnchor).isActive = true
        applyChangesButtonLabel.centerXAnchor.constraint(equalTo: applyChangesButtonView.centerXAnchor).isActive = true
    }
}

//
//  LoginViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    weak var preprofileViewControllerDelegate: PreprofileViewControllerDelegate?
    private var commandToParent: PreprofileViewController.Command = .back
    private var loginModel = LoginModel()
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Логин:"
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
        textView.isSecureTextEntry = false
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
        textView.isSecureTextEntry = false
        return textView
    }()
    private lazy var toRegistrationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Зарегистрироваться"
        label.isUserInteractionEnabled = true
        label.textColor = .systemTeal
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "PetLink"
        label.textColor = .systemTeal
        label.font = .italicSystemFont(ofSize: 30)
        return label
    }()
    private var loginButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private var loginButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Войти"
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loginLabel)
        view.addSubview(loginTextView)
        loginTextView.delegate = self
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextView)
        passwordTextView.delegate = self
        view.addSubview(toRegistrationLabel)
        toRegistrationLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toRegistrationViewController)))
        view.addSubview(titleLabel)
        view.addSubview(loginButtonView)
        view.addSubview(loginButtonLabel)
        loginButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeKeyboard)))
        setupConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        guard let preprofileViewControllerDelegate = preprofileViewControllerDelegate else { return }
        preprofileViewControllerDelegate.childIsKilled(commandToParent: commandToParent)
    }
    @objc
    private func removeKeyboard() {
        if loginTextView.isFirstResponder {
            loginTextView.resignFirstResponder()
        }
        if passwordTextView.isFirstResponder {
            passwordTextView.resignFirstResponder()
        }
    }
    @objc
    private func toRegistrationViewController() {
        print(#function)
        toRegistrationLabel.isUserInteractionEnabled = false
        guard let delegate = preprofileViewControllerDelegate else { return }
        DispatchQueue.main.async {
            self.commandToParent = .toRegistration
            self.dismiss(animated: true, completion: nil)
            self.toRegistrationLabel.isUserInteractionEnabled = true
        }
    }
    @objc
    private func login() {
        loginButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.loginButtonView.layer.opacity = 0.9
            self.loginButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.loginButtonLabel.layer.opacity = 0.9
            self.loginButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.loginButtonView.layer.opacity = 1
                self.loginButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.loginButtonLabel.layer.opacity = 1
                self.loginButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                DataManager.shared.login(loginModel: self.loginModel) { err in
                    DispatchQueue.main.async {
                        self.commandToParent = .toUserProfile
                        if err == nil {
                            self.dismiss(animated: true, completion: nil)
                        }
                        self.loginButtonView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
}
extension LoginViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == passwordTextView {
            textView.text = String(repeating: "*", count: (textView.text ?? "").count)
        } else if textView == loginTextView {
            loginModel.login = textView.text
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        if text == " " && text != "" {
            return false
        }
        if textView == passwordTextView {
            loginModel.password = ((loginModel.password) as NSString).replacingCharacters(in: range, with: text)
        }
        return true
    }
}
extension LoginViewController {
    private func setupConstraints() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        toRegistrationLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButtonView.translatesAutoresizingMaskIntoConstraints = false
        loginButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loginLabel.bottomAnchor.constraint(equalTo: loginTextView.topAnchor, constant: -5).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        loginTextView.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: -15).isActive = true
        loginTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        loginTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        loginTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordLabel.bottomAnchor.constraint(equalTo: passwordTextView.topAnchor, constant: -5).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true

        passwordTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        passwordTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        passwordTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        passwordTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        toRegistrationLabel.centerYAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 35).isActive = true
        toRegistrationLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: toRegistrationLabel.bottomAnchor, constant: 90).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        loginButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        loginButtonLabel.centerYAnchor.constraint(equalTo: loginButtonView.centerYAnchor).isActive = true
        loginButtonLabel.centerXAnchor.constraint(equalTo: loginButtonView.centerXAnchor).isActive = true
    }
}

//
//  LoginViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
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
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextView)
        view.addSubview(loginButtonView)
        view.addSubview(loginButtonLabel)
        loginButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
        setupConstraints()
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
                DataManager.shared.getUserProfile(userId: "1") { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            print(#function)
                            let viewController = UserProfileViewController()
                            var viewControllers = self.navigationController?.viewControllers ?? []
                            viewControllers.removeLast()
                            viewControllers.append(viewController)
                            self.navigationController?.setViewControllers(viewControllers, animated: true)
                        case .failure(let failure):
                            break
                        }
                        self.loginButtonView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }

}
extension LoginViewController {
    private func setupConstraints() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
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
        
        loginButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        loginButtonLabel.centerYAnchor.constraint(equalTo: loginButtonView.centerYAnchor).isActive = true
        loginButtonLabel.centerXAnchor.constraint(equalTo: loginButtonView.centerXAnchor).isActive = true
    }
}

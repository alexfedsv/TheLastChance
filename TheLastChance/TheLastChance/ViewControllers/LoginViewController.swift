//
//  LoginViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private var loginButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .blue
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
        view.backgroundColor = .purple
        view.addSubview(loginButtonView)
        view.addSubview(loginButtonLabel)
        loginButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toUserProfile)))
        setupConstraints()
    }

    @objc
    private func toUserProfile() {
        loginButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.loginButtonView.layer.opacity = 0.9
            self.loginButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.loginButtonView.layer.opacity = 1
                self.loginButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                DataManager.shared.networkServiceProtocol.getUserProfile(userId: 1) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            let viewController = UserProfileViewController()
                            viewController.userModel = UserProfileModel(json: success)
                            self.navigationController?.pushViewController(viewController, animated: false)
                            break
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
        loginButtonView.translatesAutoresizingMaskIntoConstraints = false
        loginButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loginButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        loginButtonLabel.centerYAnchor.constraint(equalTo: loginButtonView.centerYAnchor).isActive = true
        loginButtonLabel.centerXAnchor.constraint(equalTo: loginButtonView.centerXAnchor).isActive = true
    }
}

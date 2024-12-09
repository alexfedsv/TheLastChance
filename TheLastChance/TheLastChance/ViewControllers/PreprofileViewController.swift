//
//  PreprofileViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 09.12.2024.
//

import UIKit

protocol PreprofileViewControllerDelegate: AnyObject {
    func childIsKilled(commandToParent: PreprofileViewController.Command)
}

final class PreprofileViewController: UIViewController {

    enum Command {
        case toLogin
        case toRegistration
        case back
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        decisionMaker()
    }
    
    private func decisionMaker() {
        if Settings.shared.userId == "" {
            print("[DEBUG][\(#function)]: Юзер не автризован")
            let viewController = LoginViewController()
            viewController.preprofileViewControllerDelegate = self
            present(viewController, animated: false, completion: nil)
        } else {
            print("[DEBUG][\(#function)]: Юзер автризован")
            let viewController = UserHostProfileViewController()
            var viewControllers = self.navigationController?.viewControllers ?? []
            viewControllers.removeLast()
            viewControllers.append(viewController)
            self.navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
}
extension PreprofileViewController: PreprofileViewControllerDelegate {
    func childIsKilled(commandToParent: PreprofileViewController.Command) {
        print(#function)
        switch commandToParent {
        case .toLogin:
            let viewController = LoginViewController()
            viewController.preprofileViewControllerDelegate = self
            present(viewController, animated: true, completion: nil)
        case .toRegistration:
            let viewController = RegistrationViewController()
            viewController.preprofileViewControllerDelegate = self
            present(viewController, animated: true, completion: nil)
        case .back:
            if Settings.shared.userId == "" {
                print("[DEBUG][\(#function)]: Юзер не автризован")
                if let tabBarController = self.tabBarController {
                    if let viewControllers = tabBarController.viewControllers,
                       viewControllers.count > 0 {
                        tabBarController.selectedViewController = viewControllers[0]
                    }
                }
            } else {
                print("[DEBUG][\(#function)]: Юзер автризован")
                let viewController = UserHostProfileViewController()
                var viewControllers = self.navigationController?.viewControllers ?? []
                viewControllers.removeLast()
                viewControllers.append(viewController)
                self.navigationController?.setViewControllers(viewControllers, animated: true)
            }
        }
    }
}

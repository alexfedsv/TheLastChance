//
//  TabBarControllerFactory.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 09.11.2024.
//

import UIKit

final class TabBarControllerFactory {
    static func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .systemTeal
        let firstViewController = createNavController(for: ServicesViewController(), title: "Домой", imageName: "house")
        let secondViewController = createNavController(for: UserProfileViewController(), title: "Профиль", imageName: "person")
        tabBarController.viewControllers = [firstViewController, secondViewController]
        return tabBarController
    }
    
    private static func createNavController(for rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
}

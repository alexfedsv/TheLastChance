//
//  ServicesViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import UIKit

protocol ServicesViewControllerDelegate: AnyObject {
    func setModeSlaveMaster(mode: ServiceModel.Mode)
}

final class ServicesViewController: UIViewController {

    private var collectionView: UICollectionView!
    var modeSlaveMaster: ServiceModel.Mode?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: ServicesCollectionViewCell.identifier)
        view.addSubview(collectionView)
        setupConstraints()
        collectionView.reloadData()
    }
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        //let rightButtonImageFilter = UIImage(systemName: "slider.vertical.3")
        //let rightBarButtonItemFilter = UIBarButtonItem(image: rightButtonImageFilter, style: .plain, target: self, action: #selector(filterButtonTapped))
        let rightButtonImageAdd = UIImage(systemName: "plus")
        let rightBarButtonItemAdd = UIBarButtonItem(image: rightButtonImageAdd, style: .plain, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItems = [rightBarButtonItemAdd, /*rightBarButtonItemFilter*/]
        
    }
    @objc
    private func filterButtonTapped() {
        print(#function)
    }
    @objc
    private func addButtonTapped() {
        if Settings.shared.userId == "" {
            if let tabBarController = self.tabBarController {
                if let viewControllers = tabBarController.viewControllers,
                    viewControllers.count > 0 {
                    tabBarController.selectedViewController = viewControllers[1]
                }
            }
        } else {
            let viewController = AddServiceViewController()
            viewController.servicesViewController = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension ServicesViewController: ServicesViewControllerDelegate {
    func setModeSlaveMaster(mode: ServiceModel.Mode) {
        self.modeSlaveMaster = mode
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension ServicesViewController {
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}
extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let modeSlaveMaster = modeSlaveMaster else { return 0 }
        switch modeSlaveMaster {
        case .master:
            return ServicesModel.shared.servicesMaster.count
        case .slave:
            return ServicesModel.shared.servicesSlave.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let modeSlaveMaster = modeSlaveMaster else { return UICollectionViewCell() }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as? ServicesCollectionViewCell {
            switch modeSlaveMaster {
            case .master:
                cell.setup(title: ServicesModel.shared.servicesMaster[indexPath.row].title,
                           description: ServicesModel.shared.servicesMaster[indexPath.row].description,
                           imageData: ServicesModel.shared.servicesMaster[indexPath.row].userImageData)
            case .slave:
                cell.setup(title: ServicesModel.shared.servicesSlave[indexPath.row].title,
                           description: ServicesModel.shared.servicesSlave[indexPath.row].description,
                           imageData: ServicesModel.shared.servicesSlave[indexPath.row].userImageData)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let modeSlaveMaster = modeSlaveMaster else { return }
        let viewController = ServiceViewController()
        var userId: String
        var serviceModel: ServiceModel
        switch modeSlaveMaster {
        case .master:
            userId = ServicesModel.shared.servicesMaster[indexPath.row].userId
            serviceModel = ServicesModel.shared.servicesMaster[indexPath.row]
        case .slave:
            userId = ServicesModel.shared.servicesSlave[indexPath.row].userId
            serviceModel = ServicesModel.shared.servicesSlave[indexPath.row]
        }
        
        DataManager.shared.getUserProfile(userId: userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        let userModel = UserOtherProfileModel()
                        userModel.setup(userId: userId, json: success)
                        viewController.userOtherModel = userModel
                        viewController.serviceModel = serviceModel
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                case .failure(let failure):
                    break
                }
            }
        }
    }
}

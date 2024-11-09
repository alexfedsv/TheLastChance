//
//  ServicesViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import UIKit

final class ServicesViewController: UIViewController {

    var servicesModel: ServicesModel = ServicesModel()
    private var collectionView: UICollectionView!
   
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
        getServices()
        setupUser()
    }
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        let rightButtonImage = UIImage(systemName: "slider.vertical.3")
        let rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(filterButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    private func getServices() {
        DataManager.shared.getServices { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    for elem in success.services {
                        self.servicesModel.services.append(ServiceModel(json: elem))
                    }
                    self.collectionView.reloadData()
                case .failure(let failure):
                    break
                }
            }
        }
    }
    private func setupUser() {
        DataManager.shared.getUserProfile(userId: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        UserOwnerProfileModel.shared.setup(json: success)
                    }
                case .failure(let failure):
                    break
                }
            }
        }
    }
    @objc
    private func filterButtonTapped() {
        print(#function)
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
        return servicesModel.services.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as? ServicesCollectionViewCell {
            cell.setup(title: servicesModel.services[indexPath.row].title, description: servicesModel.services[indexPath.row].description, imageData: servicesModel.services[indexPath.row].petImageData)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
}

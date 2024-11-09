//
//  ServicesViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import UIKit

final class ServicesViewController: UIViewController {

    var servicesModel: ServicesModel = ServicesModel()
    private var navBarView = NavBarView()
    private var collectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBarView)
        navBarView.setup(delegate: self, leftImage: UIImage(systemName: "chevron.backward"), leftCenterImage: UIImage(systemName: "house"), rightCenterImage: UIImage(systemName: "plus"), rightImage: UIImage(systemName: "slider.vertical.3"))
        view.backgroundColor = .purple
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .purple
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: ServicesCollectionViewCell.identifier)
        view.addSubview(collectionView)
        setupConstraints()
    }
}

extension ServicesViewController: NavBarViewDelegate {
    func navBarLeftButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func navBarLeftCenterButtonTapped() {
        print(#function)
    }
    func navBarRightCenterButtonTapped() {
        let viewController = AddServiceViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    func navBarRightButtonTapped() {
        print(#function)
    }
}
extension ServicesViewController {
    private func setupConstraints() {
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navBarView.heightAnchor.constraint(equalToConstant: NavBarView.viewHeight).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 10).isActive = true
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
            cell.setup(title: servicesModel.services[indexPath.row].title, description: servicesModel.services[indexPath.row].description, userImageData: servicesModel.services[indexPath.row].userImageData, petImageData: servicesModel.services[indexPath.row].petImageData)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
}

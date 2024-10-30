//
//  ServicesViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import UIKit

final class ServicesViewController: UIViewController {

    var services: [ServicesModel] = []
    private var navBarView = NavBarView()
    var collectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBarView)
        navBarView.setup(delegate: self, leftImage: UIImage(systemName: "chevron.backward"), leftCenterImage: nil, rightCenterImage: nil, rightImage: nil)
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
        getServices()
    }
    private func getServices() {
        
    }
}

extension ServicesViewController: NavBarViewDelegate {
    func navBarLeftButtonTapped() {
        print(#function)
    }
    func navBarLeftCenterButtonTapped() {
        print(#function)
    }
    func navBarRightCenterButtonTapped() {
        print(#function)
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
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
}
extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as? ServicesCollectionViewCell {
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}

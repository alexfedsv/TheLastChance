//
//  ViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import UIKit

final class UserProfileViewController: UIViewController {

    var userModel: UserProfileModel?
    var petsModel: PetsModel = PetsModel()
    private var navBarView = NavBarView()
    private var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private var separator0View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    private var separator1View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    private var separator2View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private var contactsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    var collectionView: UICollectionView!
    private var testLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private var toServicesButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .blue
        return view
    }()
    private var toServicesButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "К услугам"
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(usernameLabel)
        view.addSubview(contactsLabel)
        view.addSubview(separator1View)
        navBarView.setup(delegate: self, leftImage: UIImage(systemName: "chevron.backward"), leftCenterImage: nil, rightCenterImage: nil, rightImage: nil)
        view.addSubview(testLabel)
        view.addSubview(toServicesButtonView)
        toServicesButtonView.addSubview(toServicesButtonLabel)
        toServicesButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toServices)))
        view.backgroundColor = .purple
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .purple
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.identifier)
        collectionView.register(PetAddCollectionViewCell.self, forCellWithReuseIdentifier: PetAddCollectionViewCell.identifier)
        view.addSubview(collectionView)
        view.addSubview(separator2View)
        setupConstraints()
        getUser()
        getPets()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width / 2
    }
    private func setupUser() {
        guard let userModel = userModel else { return }
        DispatchQueue.main.async {
            self.usernameLabel.text = userModel.username
            self.contactsLabel.text = userModel.contacts
            if let userImage = userModel.userImage {
                self.userPhotoImageView.image = UIImage(data: userImage)
            } else {
                self.userPhotoImageView.image = nil
            }
        }
    }
    private func getUser() {
        DataManager.shared.networkServiceProtocol.getUserProfile(userId: 1) { result in
            switch result {
            case .success(let success):
                self.userModel = UserProfileModel(json: success)
                self.setupUser()
            case .failure(let failure):
                print("[ERROR]: \(failure.message())")
            }
        }
    }
    private func getPets() {
        let dispatchGroup = DispatchGroup()
        DataManager.shared.networkServiceProtocol.getPets(userId: 1) { resultPetIds in
            switch resultPetIds {
            case .success(let successPetIds):
                for petId in successPetIds.petIds {
                    dispatchGroup.enter()
                    DataManager.shared.networkServiceProtocol.getPetProfile(petId: petId) { resultPetProfile in
                        switch resultPetProfile {
                        case .success(let successPetProfile):
                            self.petsModel.pets.append(PetProfileModel(json: successPetProfile))
                        case .failure(let failurePetProfile):
                            print("[ERROR]: \(failurePetProfile.message())")
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let failurePetIds):
                print("[ERROR]: \(failurePetIds.message())")
            }
        }
    }
    @objc
    private func toServices() {
        toServicesButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.toServicesButtonView.layer.opacity = 0.9
            self.toServicesButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.toServicesButtonView.layer.opacity = 1
                self.toServicesButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                /*DataManager.shared.networkServiceProtocol.getPetProfile(petId: 1) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            let petModel = PetProfileModel(json: success)
                            self.toPetProfileViewController(petModel: petModel)
                        case .failure(let failure):
                            self.testLabel.text = failure.message()
                            self.toPetProfileViewController(petModel: PetProfileModel(typeOfAnimal: "Злой кот", petAvatar: "Быстрый зверь", petName: "Барсик"))
                        }
                        self.toServicesestButtonView.isUserInteractionEnabled = true
                    }
                }*/
                DataManager.shared.networkServiceProtocol.getServices { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            let servicesModel: ServicesModel = ServicesModel()
                            for elem in success.services {
                                servicesModel.services.append(ServiceModel(json: elem))
                            }
                            self.toServicesViewController(servicesModel: servicesModel)
                        case .failure(let failure):
                            break
                        }
                        self.toServicesButtonView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    private func toPetProfileViewController(petModel: PetProfileModel) {
        let viewController = PetProfileViewController()
        viewController.petModel = petModel
        viewController.userModel = userModel
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    private func toServicesViewController(servicesModel: ServicesModel) {
        let viewController = ServicesViewController()
        viewController.servicesModel = servicesModel
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    private func toAddEditPetViewController() {
        let viewController = AddEditPetViewController()
        viewController.userModel = userModel
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
}

extension UserProfileViewController: NavBarViewDelegate {
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
extension UserProfileViewController {
    private func setupConstraints() {
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        toServicesButtonView.translatesAutoresizingMaskIntoConstraints = false
        toServicesButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navBarView.heightAnchor.constraint(equalToConstant: NavBarView.viewHeight).isActive = true
        
        userPhotoImageView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 30).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 30).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        
        contactsLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        contactsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        separator2View.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        testLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        testLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        testLabel.bottomAnchor.constraint(equalTo: toServicesButtonView.topAnchor, constant: -40).isActive = true
        
        toServicesButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        toServicesButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        toServicesButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        toServicesButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        toServicesButtonLabel.centerYAnchor.constraint(equalTo: toServicesButtonView.centerYAnchor).isActive = true
        toServicesButtonLabel.centerXAnchor.constraint(equalTo: toServicesButtonView.centerXAnchor).isActive = true
    }
}
extension UserProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsModel.pets.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < petsModel.pets.count {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionViewCell.identifier, for: indexPath) as? PetCollectionViewCell {
                cell.setup(title: petsModel.pets[indexPath.row].typeOfAnimal, name: petsModel.pets[indexPath.row].petName, imageData: petsModel.pets[indexPath.row].petAvatar)
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetAddCollectionViewCell.identifier, for: indexPath) as? PetAddCollectionViewCell {
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < petsModel.pets.count {
            let petModel = petsModel.pets[indexPath.row]
            print("Выбрано животное: \(petModel.petName) из типа: \(petModel.typeOfAnimal)")
            toPetProfileViewController(petModel: petModel)
        }
        if indexPath.row == petsModel.pets.count {
            toAddEditPetViewController()
        }
    }
}

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
    private var userBackgroundPhotoImageView: UserBackgroundPhotoImageView = {
        let imageView = UserBackgroundPhotoImageView()
        imageView.backgroundColor = .systemTeal
        imageView.image = UIImage(named: "Mock/animals")
        return imageView
    }()
    private var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemTeal
        return imageView
    }()
    private var separator0View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private var separator1View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private var separator2View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    private var contactsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(userBackgroundPhotoImageView)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(usernameLabel)
        view.addSubview(contactsLabel)
        view.addSubview(separator1View)
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.identifier)
        collectionView.register(PetAddCollectionViewCell.self, forCellWithReuseIdentifier: PetAddCollectionViewCell.identifier)
        view.addSubview(collectionView)
        view.addSubview(separator2View)
        setupConstraints()
        getPets()
        setupUser()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width / 2
    }
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        let rightButtonImage = UIImage(systemName: "gearshape")
        let rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(toSettings))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    private func setupUser() {
        DataManager.shared.getUserProfile(userId: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        let userModel = UserProfileModel(json: success)
                        self.userModel = userModel
                        self.usernameLabel.text = userModel.username
                        self.contactsLabel.text = userModel.contacts
                        if let userImage = userModel.userImage {
                            self.userPhotoImageView.image = UIImage(data: userImage)
                        } else {
                            self.userPhotoImageView.image = nil
                        }
                    }
                case .failure(let failure):
                    break
                }
            }
        }
    }
    private func getPets() {
        let dispatchGroup = DispatchGroup()
        DataManager.shared.getPets(userId: 1) { resultPetIds in
            switch resultPetIds {
            case .success(let successPetIds):
                for petId in successPetIds.petIds {
                    dispatchGroup.enter()
                    DataManager.shared.getPetProfile(petId: petId) { resultPetProfile in
                        switch resultPetProfile {
                        case .success(let successPetProfile):
                            self.petsModel.pets.append(successPetProfile)
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
    private func toPetProfileViewController(petModel: PetProfileModel) {
        let viewController = PetProfileViewController()
        viewController.petModel = petModel
        viewController.userModel = userModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    private func toAddEditPetViewController(petModel: PetProfileModel) {
        let viewController = AddEditPetViewController()
        viewController.petModel = petModel
        viewController.userModel = userModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func toSettings() {
        print(#function)
    }
    @objc
    private func backPressed() {
        print(#function)
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
        userBackgroundPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        
        userBackgroundPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userBackgroundPhotoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        userBackgroundPhotoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        userBackgroundPhotoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: 10).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        
        contactsLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        contactsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        contactsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        separator2View.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
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
            let petModel = PetProfileModel(petId: 0, typeOfAnimal: "", petName: "", info: "", petAvatar: "")
            toAddEditPetViewController(petModel: petModel)
        }
    }
}

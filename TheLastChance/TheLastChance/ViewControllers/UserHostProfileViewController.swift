//
//  ViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import UIKit


final class UserHostProfileViewController: UIViewController {

    var petsModel: PetsModel = PetsModel()
    private var myServices: [ServiceModel] = []
    private var userBackgroundPhotoImageView: UserBackgroundPhotoImageView = {
        let imageView = UserBackgroundPhotoImageView()
        imageView.backgroundColor = .systemTeal.withAlphaComponent(0.25)
        return imageView
    }()
    private var backgroundPhotoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondarySystemBackground
        label.shadowColor = .systemTeal
        label.shadowOffset = .init(width: 2, height: 2)
        label.text = ""
        label.numberOfLines = 1
        return label
    }()
    private var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .secondarySystemBackground
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
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    private var contactsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    var collectionPetsView: UICollectionView!
    var collectionServicesView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(userBackgroundPhotoImageView)
        userBackgroundPhotoImageView.addSubview(backgroundPhotoLabel)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(usernameLabel)
        view.addSubview(contactsLabel)
        view.addSubview(separator1View)
        view.backgroundColor = .systemBackground
        let layoutPets = UICollectionViewFlowLayout()
        layoutPets.scrollDirection = .horizontal
        layoutPets.minimumLineSpacing = 10
        layoutPets.minimumInteritemSpacing = 10
        collectionPetsView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layoutPets)
        collectionPetsView.backgroundColor = .systemBackground
        collectionPetsView.dataSource = self
        collectionPetsView.delegate = self
        collectionPetsView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.identifier)
        collectionPetsView.register(PetAddCollectionViewCell.self, forCellWithReuseIdentifier: PetAddCollectionViewCell.identifier)
        view.addSubview(collectionPetsView)
        view.addSubview(separator2View)
        let layoutServices = UICollectionViewFlowLayout()
        layoutServices.scrollDirection = .vertical
        layoutServices.minimumLineSpacing = 10
        layoutServices.minimumInteritemSpacing = 10
        collectionServicesView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layoutServices)
        collectionServicesView.backgroundColor = .systemBackground
        collectionServicesView.dataSource = self
        collectionServicesView.delegate = self
        collectionServicesView.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: ServicesCollectionViewCell.identifier)
        view.addSubview(collectionServicesView)
        setupConstraints()
        setupUser()
        getPets()
        getMyServices()
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
        let rightButtonImageSettings = UIImage(systemName: "gearshape")
        let rightBarButtonSettings = UIBarButtonItem(image: rightButtonImageSettings, style: .plain, target: self, action: #selector(settingButtonTapped))
        let rightButtonEditProfile = UIImage(systemName: "pencil")
        let rightBarButtonEditProfile = UIBarButtonItem(image: rightButtonEditProfile, style: .plain, target: self, action: #selector(toEditProfile))
        self.navigationItem.rightBarButtonItems = [rightBarButtonEditProfile, rightBarButtonSettings]
    }
    func setupUser() {
        self.usernameLabel.text = UserHostProfileModel.shared.username
        self.contactsLabel.text = UserHostProfileModel.shared.contacts
        if let userImage = UserHostProfileModel.shared.userImage {
            self.userPhotoImageView.image = UIImage(data: userImage)
        } else {
            self.userPhotoImageView.image = UIImage(systemName: "person.crop.circle")
        }
        if let backgroundImage = UserHostProfileModel.shared.backgroundImage {
            self.userBackgroundPhotoImageView.image = UIImage(data: backgroundImage)
        }
    }
    private func getMyServices() {
        if !ServicesModel.shared.isLoaded {
            DataManager.shared.getServices { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        let viewController = ServicesViewController()
                        for elem in success {
                            if elem.role == "master" {
                                ServicesModel.shared.servicesMaster.append(ServiceModel(json: elem))
                            }
                            if elem.role == "slave" {
                                ServicesModel.shared.servicesSlave.append(ServiceModel(json: elem))
                            }
                        }
                        self.myServices = ServicesModel.shared.servicesMaster.filter({ $0.userId == Settings.shared.userId }) + ServicesModel.shared.servicesSlave.filter({ $0.userId == Settings.shared.userId })
                        self.collectionServicesView.reloadData()
                        ServicesModel.shared.isLoaded = true
                    case .failure(let failure):
                        print("фиаско")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.myServices = ServicesModel.shared.servicesMaster.filter({ $0.userId == Settings.shared.userId }) + ServicesModel.shared.servicesSlave.filter({ $0.userId == Settings.shared.userId })
                self.collectionServicesView.reloadData()
            }
        }
        
    }
    private func getPets() {
        let dispatchGroup = DispatchGroup()
        DataManager.shared.getPets(userId: UserHostProfileModel.shared.userId) { resultPetIds in
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
                        self.collectionPetsView.reloadData()
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
        viewController.userModel = UserHostProfileModel.shared
        viewController.isHost = true
        viewController.userViewController = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    private func toAddPetViewController(petModel: PetProfileModel) {
        let viewController = AddPetViewController()
        viewController.userViewController = self
        viewController.petModel = petModel
        viewController.userModel = UserHostProfileModel.shared
        viewController.userViewController = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func toEditProfile() {
        let viewController = UserEditViewController()
        viewController.userViewController = self
        viewController.userModel = UserHostProfileModel.shared
        viewController.userViewController = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func settingButtonTapped() {
        let viewController = SettingsViewController()
        viewController.userViewController = self
        viewController.userModel = UserHostProfileModel.shared
        viewController.userViewController = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func backPressed() {
        print(#function)
    }
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionPetsView.reloadData()
        }
    }
}

extension UserHostProfileViewController {
    private func setupConstraints() {
        userBackgroundPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        collectionPetsView.translatesAutoresizingMaskIntoConstraints = false
        collectionServicesView.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        
        userBackgroundPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userBackgroundPhotoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        userBackgroundPhotoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        userBackgroundPhotoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        backgroundPhotoLabel.trailingAnchor.constraint(equalTo: userBackgroundPhotoImageView.trailingAnchor, constant: -15).isActive = true
        backgroundPhotoLabel.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        
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
        
        collectionPetsView.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        collectionPetsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionPetsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        collectionPetsView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        separator2View.topAnchor.constraint(equalTo: collectionPetsView.bottomAnchor, constant: 10).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        collectionServicesView.topAnchor.constraint(equalTo: separator2View.bottomAnchor, constant: 10).isActive = true
        collectionServicesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionServicesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        collectionServicesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
}
extension UserHostProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionPetsView {
            return petsModel.pets.count + 1
        } else if collectionView == collectionServicesView {
            return myServices.count
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionPetsView {
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
        } else if collectionView == collectionServicesView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as? ServicesCollectionViewCell {
                cell.setup(title: myServices[indexPath.row].title,
                           description: myServices[indexPath.row].description,
                           imageData: myServices[indexPath.row].userImageData)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionPetsView {
            return CGSize(width: 100, height: 150)
        } else if collectionView == collectionServicesView {
            return CGSize(width: collectionView.bounds.width, height: 70)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionPetsView {
            if indexPath.row < petsModel.pets.count {
                let petModel = petsModel.pets[indexPath.row]
                print("Выбрано животное: \(petModel.petName) из типа: \(petModel.typeOfAnimal)")
                toPetProfileViewController(petModel: petModel)
            }
            if indexPath.row == petsModel.pets.count {
                let petModel = PetProfileModel(petId: "0", typeOfAnimal: "", petName: "", info: "", petAvatar: "")
                toAddPetViewController(petModel: petModel)
            }
        } else if collectionView == collectionServicesView  {
            
        }
    }
}

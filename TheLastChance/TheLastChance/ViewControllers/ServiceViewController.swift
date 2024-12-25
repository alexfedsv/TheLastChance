//
//  ServiceViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 13.11.2024.
//

import UIKit

class ServiceViewController: BaseViewController {

    var serviceModel: ServiceModel?
    var userModel: UserProfileModel?
    private var petsModel: PetsModel = PetsModel()
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private let descriptionLabelsFontSize: CGFloat = 16
    private let contentLabelsFontSize: CGFloat = 15
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.tintColor = .systemTeal
        return imageView
    }()
    private lazy var userRole: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemTeal
        label.shadowColor = .secondarySystemBackground
        label.shadowOffset = .init(width: 2, height: 2)
        label.numberOfLines = 1
        return label
    }()
    private lazy var separator0View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private lazy var separator1View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private lazy var separator2View: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        return view
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    private lazy var titleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Заголовок:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Описание:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Стоимость услуги:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        return label
    }()
    private lazy var priceValLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.text = "рублей"
        label.numberOfLines = 1
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        return label
    }()
    private lazy var toContactsButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private lazy var toContactsButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "К профилю"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(scrollView)
        view.backgroundColor = .systemBackground
        scrollView.addSubview(contentView)
        contentView.addSubview(userPhotoImageView)
        contentView.addSubview(userRole)
        contentView.addSubview(separator0View)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(separator1View)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleTitleLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceTitleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceValLabel)
        contentView.addSubview(separator2View)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.identifier)
        contentView.addSubview(collectionView)
        contentView.addSubview(toContactsButtonView)
        toContactsButtonView.addSubview(toContactsButtonLabel)
        toContactsButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toContacts)))
        setupConstraints()
        getPets()
        setupData()
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
        if serviceModel?.userId == Settings.shared.userId {
            let rightButtonImage = UIImage(systemName: "trash")
            let rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(removeService))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    private func setupData() {
        guard let userModel = userModel else { return }
        guard let serviceModel = serviceModel else { return }
        DispatchQueue.main.async {
            self.userModel = userModel
            switch serviceModel.role {
            case .master:
                self.userRole.text = "ЗАКАЗЧИК"
            case .slave:
                self.userRole.text = "ИСПОЛНИТЕЛЬ"
            }
            self.usernameLabel.text = userModel.username
            self.titleLabel.text = serviceModel.title
            self.descriptionLabel.text = serviceModel.description
            self.priceLabel.text = String(serviceModel.price)
            if let userImage = userModel.userImage {
                self.userPhotoImageView.image = UIImage(data: userImage)
            } else {
                self.userPhotoImageView.image = UIImage(systemName: "person.crop.circle")
            }
        }
    }
    private func getPets() {
        guard let serviceModel = serviceModel else { return }
        let petIds = serviceModel.petIds
        let dispatchGroup = DispatchGroup()
        for petId in petIds {
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
    }
    private func toPetProfileViewController(petModel: PetProfileModel) {
        guard let userModel = userModel else { return }
        let viewController = PetProfileViewController()
        viewController.petModel = petModel
        viewController.userModel = userModel
        viewController.isHost = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func toContacts() {
        guard let serviceModel = serviceModel else { return }
        toContactsButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.toContactsButtonView.layer.opacity = 0.9
            self.toContactsButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.toContactsButtonLabel.layer.opacity = 0.9
            self.toContactsButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.toContactsButtonView.layer.opacity = 1
                self.toContactsButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.toContactsButtonLabel.layer.opacity = 1
                self.toContactsButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                DataManager.shared.getUserProfile(userId: serviceModel.userId) { userProfileResult in
                    DispatchQueue.main.async {
                        switch userProfileResult {
                        case .success(let userProfile):
                            let viewController = UserOtherProfileViewController()
                            let otherProfileModel = UserOtherProfileModel()
                            otherProfileModel.setup(userId: serviceModel.userId, json: userProfile)
                            viewController.userModel = otherProfileModel
                            self.navigationController?.pushViewController(viewController, animated: true)
                        case .failure(let failure):
                            break
                        }
                        self.toContactsButtonView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    @objc
    private func removeService() {
        print(#function)
    }
}
extension ServiceViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userRole.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceValLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toContactsButtonView.translatesAutoresizingMaskIntoConstraints = false
        toContactsButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        userPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        userRole.centerXAnchor.constraint(equalTo: userPhotoImageView.centerXAnchor).isActive = true
        userRole.centerYAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor, constant: 40).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 10).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 10).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35).isActive = true
        
        toContactsButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60).isActive = true
        toContactsButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60).isActive = true
        toContactsButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        toContactsButtonView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        
        toContactsButtonLabel.centerYAnchor.constraint(equalTo: toContactsButtonView.centerYAnchor).isActive = true
        toContactsButtonLabel.centerXAnchor.constraint(equalTo: toContactsButtonView.centerXAnchor).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: toContactsButtonLabel.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        titleTitleLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        titleTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: titleTitleLabel.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        descriptionTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        priceTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        priceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        priceTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        priceValLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 5).isActive = true
        priceValLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5).isActive = true
        
        separator2View.topAnchor.constraint(greaterThanOrEqualTo: priceLabel.bottomAnchor, constant: 15).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: separator2View.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }
}
extension ServiceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsModel.pets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionViewCell.identifier, for: indexPath) as? PetCollectionViewCell {
            cell.setup(title: petsModel.pets[indexPath.row].typeOfAnimal, name: petsModel.pets[indexPath.row].petName, imageData: petsModel.pets[indexPath.row].petAvatar)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let petModel = petsModel.pets[indexPath.row]
        print("Выбрано животное: \(petModel.petName) из типа: \(petModel.typeOfAnimal)")
        toPetProfileViewController(petModel: petModel)
    }
}

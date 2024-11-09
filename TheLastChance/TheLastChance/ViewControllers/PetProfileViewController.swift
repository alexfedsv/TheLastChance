//
//  PetProfileViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import UIKit

final class PetProfileViewController: UIViewController {

    var userModel: UserProfileModel?
    var petModel: PetProfileModel?
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var petPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
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
    private lazy var typeOfAnimalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    private lazy var petnameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(petPhotoImageView)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(typeOfAnimalLabel)
        view.addSubview(petnameLabel)
        view.addSubview(separator1View)
        view.backgroundColor = .systemBackground
        view.addSubview(infoLabel)
        view.addSubview(separator2View)
        setupConstraints()
        setupData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width / 2
        petPhotoImageView.layer.cornerRadius = petPhotoImageView.bounds.width / 2
    }
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        let rightButtonImage = UIImage(systemName: "pencil")
        let rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(toAddEditPetViewController))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    private func setupData() {
        guard let petModel = petModel else { return }
        guard let userModel = userModel else { return }
        DispatchQueue.main.async {
            if let icon = userModel.userImage  {
                self.userPhotoImageView.image = UIImage(data: icon)
            } else {
                self.userPhotoImageView.image = nil
            }
            if let icon = petModel.petAvatar  {
                self.petPhotoImageView.image = UIImage(data: icon)
            } else {
                self.petPhotoImageView.image = nil
            }
            self.typeOfAnimalLabel.text = petModel.typeOfAnimal
            self.petnameLabel.text = petModel.petName
            self.infoLabel.text = petModel.info
        }
    }
    @objc
    private func toAddEditPetViewController() {
        let viewController = AddEditPetViewController()
        viewController.userModel = userModel
        viewController.petModel = petModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PetProfileViewController: NavBarViewDelegate {
    func navBarLeftButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func navBarLeftCenterButtonTapped() {
        print(#function)
    }
    func navBarRightCenterButtonTapped() {
        print(#function)
    }
    func navBarRightButtonTapped() {
        toAddEditPetViewController()
    }
}
extension PetProfileViewController {
    private func setupConstraints() {
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        petPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalLabel.translatesAutoresizingMaskIntoConstraints = false
        petnameLabel.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        
        petPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        petPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        petPhotoImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        petPhotoImageView.heightAnchor.constraint(equalTo: petPhotoImageView.widthAnchor).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor).isActive = true
        userPhotoImageView.leadingAnchor.constraint(equalTo: petPhotoImageView.trailingAnchor, constant: -30).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor, constant: 30).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        typeOfAnimalLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        typeOfAnimalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        typeOfAnimalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        
        petnameLabel.topAnchor.constraint(equalTo: typeOfAnimalLabel.bottomAnchor, constant: 5).isActive = true
        petnameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        petnameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: petnameLabel.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        separator2View.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
}

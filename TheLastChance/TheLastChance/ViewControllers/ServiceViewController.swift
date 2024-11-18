//
//  ServiceViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 13.11.2024.
//

import UIKit

class ServiceViewController: UIViewController {

    var serviceModel: ServiceModel?
    private var userModel: UserProfileModel?
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var userRole: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
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
        view.addSubview(userPhotoImageView)
        view.addSubview(userRole)
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
    }
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        /*let rightButtonImage = UIImage(systemName: "pencil")
        let rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(toAddEditPetViewController))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem*/
    }
    private func setupData() {
        guard let serviceModel = serviceModel else { return }
        DataManager.shared.getUserProfile(userId: serviceModel.userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        let userModel = UserProfileModel(json: success)
                        self.userModel = userModel
                        switch serviceModel.role {
                        case .master:
                            self.userRole.text = "ЗАКАЗЧИК"
                        case .slave:
                            self.userRole.text = "ИСПОЛНИТЕЛЬ"
                        }
                        //self.usernameLabel.text = userModel.username
                        //self.contactsLabel.text = userModel.contacts
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
}
extension ServiceViewController {
    private func setupConstraints() {
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userRole.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalLabel.translatesAutoresizingMaskIntoConstraints = false
        petnameLabel.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        
        userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        userRole.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 10).isActive = true
        userRole.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: userRole.bottomAnchor, constant: 30).isActive = true
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

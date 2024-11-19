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
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var userBackgroundPhotoImageView: UserBackgroundPhotoImageView = {
        let imageView = UserBackgroundPhotoImageView()
        imageView.backgroundColor = .systemTeal
        imageView.image = UIImage(named: "Mock/animals")
        return imageView
    }()
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var userRole: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemBackground
        label.shadowColor = .secondarySystemBackground
        label.shadowOffset = .init(width: 1, height: 1)
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
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
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
        label.text = "Контанты"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(scrollView)
        view.backgroundColor = .systemBackground
        scrollView.addSubview(contentView)
        contentView.addSubview(userBackgroundPhotoImageView)
        contentView.addSubview(userPhotoImageView)
        contentView.addSubview(userRole)
        contentView.addSubview(separator0View)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(separator1View)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(separator2View)
        contentView.addSubview(toContactsButtonView)
        toContactsButtonView.addSubview(toContactsButtonLabel)
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
                        self.usernameLabel.text = userModel.username
                        self.titleLabel.text = serviceModel.title
                        var test = ""
                        for i in 0...1000 {
                            test.append("x ")
                        }
                        self.descriptionLabel.text = serviceModel.description + test
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
    @objc
    private func toContacts() {
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
                DataManager.shared.getUserProfile(userId: 1) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            print(#function)
                            break
                        case .failure(let failure):
                            break
                        }
                        self.toContactsButtonView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
}
extension ServiceViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        userBackgroundPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userRole.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
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

        userBackgroundPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        userBackgroundPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        userBackgroundPhotoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        userBackgroundPhotoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: -10).isActive = true
        userPhotoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        userRole.centerXAnchor.constraint(equalTo: userPhotoImageView.centerXAnchor).isActive = true
        userRole.centerYAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor, constant: 40).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: userBackgroundPhotoImageView.bottomAnchor, constant: 10).isActive = true
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
        
        titleLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        separator2View.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
        separator2View.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}

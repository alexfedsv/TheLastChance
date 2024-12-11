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
    var isHost: Bool = false
    private let descriptionLabelsFontSize: CGFloat = 16
    private let contentLabelsFontSize: CGFloat = 15
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemTeal
        return imageView
    }()
    private lazy var petPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemTeal
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
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Вид питомца:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var petnameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Имя питомца:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Дополнительная информация:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var adviceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: descriptionLabelsFontSize)
        label.text = "Совет по уходу:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var typeOfAnimalContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        return label
    }()
    private lazy var petnameContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        return label
    }()
    private lazy var infoContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        return label
    }()
    private lazy var adviceView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    private lazy var adviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gobackward")
        imageView.backgroundColor = .secondarySystemBackground
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var adviceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: contentLabelsFontSize)
        label.numberOfLines = 0
        label.text = "advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет advice совет"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(petPhotoImageView)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(typeOfAnimalLabel)
        view.addSubview(typeOfAnimalContentLabel)
        view.addSubview(petnameLabel)
        view.addSubview(petnameContentLabel)
        view.addSubview(separator1View)
        view.backgroundColor = .systemBackground
        view.addSubview(infoLabel)
        view.addSubview(infoContentLabel)
        view.addSubview(separator2View)
        view.addSubview(adviceView)
        view.addSubview(adviceDescriptionLabel)
        adviceView.addSubview(adviceImageView)
        adviceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getAdvice)))
        adviceView.addSubview(adviceLabel)
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
        if isHost {
            self.navigationItem.backBarButtonItem = backButton
            let rightButtonImage = UIImage(systemName: "pencil")
            let rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(toAddEditPetViewController))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
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
            self.typeOfAnimalContentLabel.text = petModel.typeOfAnimal
            self.petnameContentLabel.text = petModel.petName
            self.infoContentLabel.text = petModel.info
        }
    }
    @objc
    private func toAddEditPetViewController() {
        let viewController = AddEditPetViewController()
        viewController.userModel = UserHostProfileModel.shared
        viewController.petModel = petModel
        viewController.addEdit = .editPet
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc
    private func getAdvice() {
        print(#function)
    }
}
extension PetProfileViewController {
    private func setupConstraints() {
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        petPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalLabel.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalContentLabel.translatesAutoresizingMaskIntoConstraints = false
        petnameLabel.translatesAutoresizingMaskIntoConstraints = false
        petnameContentLabel.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoContentLabel.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        adviceDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        adviceView.translatesAutoresizingMaskIntoConstraints = false
        adviceImageView.translatesAutoresizingMaskIntoConstraints = false
        adviceLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        typeOfAnimalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        typeOfAnimalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        typeOfAnimalContentLabel.topAnchor.constraint(equalTo: typeOfAnimalLabel.bottomAnchor, constant: 5).isActive = true
        typeOfAnimalContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        typeOfAnimalContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        petnameLabel.topAnchor.constraint(equalTo: typeOfAnimalContentLabel.bottomAnchor, constant: 5).isActive = true
        petnameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        petnameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        petnameContentLabel.topAnchor.constraint(equalTo: petnameLabel.bottomAnchor, constant: 5).isActive = true
        petnameContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        petnameContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: petnameContentLabel.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        infoContentLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5).isActive = true
        infoContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        infoContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        separator2View.topAnchor.constraint(equalTo: infoContentLabel.bottomAnchor, constant: 5).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        adviceDescriptionLabel.topAnchor.constraint(equalTo: separator2View.bottomAnchor, constant: 15).isActive = true
        adviceDescriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        adviceDescriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        adviceView.topAnchor.constraint(equalTo: adviceDescriptionLabel.bottomAnchor, constant: 5).isActive = true
        adviceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        adviceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        adviceImageView.topAnchor.constraint(equalTo: adviceView.topAnchor, constant: 5).isActive = true
        adviceImageView.trailingAnchor.constraint(equalTo: adviceView.trailingAnchor, constant: -5).isActive = true
        adviceImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        adviceImageView.widthAnchor.constraint(equalTo: adviceImageView.heightAnchor).isActive = true
        
        adviceLabel.topAnchor.constraint(equalTo: adviceView.topAnchor, constant: 17).isActive = true
        adviceLabel.bottomAnchor.constraint(equalTo: adviceView.bottomAnchor, constant: -15).isActive = true
        adviceLabel.leadingAnchor.constraint(equalTo: adviceView.leadingAnchor, constant: 15).isActive = true
        adviceLabel.trailingAnchor.constraint(equalTo: adviceView.trailingAnchor, constant: -15).isActive = true
        
    }
}

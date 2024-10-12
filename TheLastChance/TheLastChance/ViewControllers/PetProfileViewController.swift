//
//  PetProfileViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import UIKit

class PetProfileViewController: UIViewController {
    
    var petModel: PetModel?
    private var navBarView = NavBarView()
    private var petPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")
        return imageView
    }()
    private var typeOfAnimalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private var petBreedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private var petNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navBarView)
        view.addSubview(petPhotoImageView)
        view.addSubview(typeOfAnimalLabel)
        view.addSubview(petBreedLabel)
        view.addSubview(petNameLabel)
        typeOfAnimalLabel.text = "Тип зверя: " + (petModel?.typeOfAnimal ?? "")
        petBreedLabel.text = "Порода зверя: " + (petModel?.petBreed ?? "")
        petNameLabel.text = "Имя зверя: " + (petModel?.petName ?? "")
        navBarView.setup(delegate: self, leftImage: UIImage(systemName: "chevron.backward"), leftCenterImage: nil, rightCenterImage: nil, rightImage: nil)
        setupConstraints()
    }
    

}
extension PetProfileViewController: NavBarViewDelegate {
    func navBarLeftButtonTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
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
extension PetProfileViewController {
    private func setupConstraints() {
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        petPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalLabel.translatesAutoresizingMaskIntoConstraints = false
        petBreedLabel.translatesAutoresizingMaskIntoConstraints = false
        petNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navBarView.heightAnchor.constraint(equalToConstant: NavBarView.viewHeight).isActive = true
        
        petPhotoImageView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 30).isActive = true
        petPhotoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        petPhotoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        petPhotoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        typeOfAnimalLabel.topAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor, constant: 20).isActive = true
        typeOfAnimalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        typeOfAnimalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        petBreedLabel.topAnchor.constraint(equalTo: typeOfAnimalLabel.bottomAnchor, constant: 20).isActive = true
        petBreedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        petBreedLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        petNameLabel.topAnchor.constraint(equalTo: petBreedLabel.bottomAnchor, constant: 20).isActive = true
        petNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        petNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true

    }
}

//
//  ViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import UIKit

class ViewController: UIViewController {

    private var testLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private var testButton: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .blue
        return view
    }()
    private var testButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "TEST"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        view.addSubview(testButton)
        testButton.addSubview(testButtonLabel)
        testButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(test)))
        view.backgroundColor = .red
        setupConstraints()
    }
    @objc
    private func test() {
        testButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.testButton.layer.opacity = 0.9
            self.testButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.testButton.layer.opacity = 1
                self.testButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                /*DataManager.shared.networkServiceProtocol.test { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            self.testLabel.text = success.test
                        case .failure(let failure):
                            self.testLabel.text = failure.message()
                        }
                        self.testButton.isUserInteractionEnabled = true
                    }
                }*/
                DataManager.shared.networkServiceProtocol.getPetProfile { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            let petModel = PetModel(json: success)
                            self.toPetProfileViewController(petModel: petModel)
                        case .failure(let failure):
                            self.testLabel.text = failure.message()
                            self.toPetProfileViewController(petModel: PetModel(typeOfAnimal: "Злой кот", petBreed: "Быстрый зверь", petName: "Барсик"))
                        }
                        self.testButton.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    private func toPetProfileViewController(petModel: PetModel) {
        let viewController = PetProfileViewController()
        viewController.petModel = petModel
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
extension ViewController {
    private func setupConstraints() {
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        testLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        testLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        testLabel.bottomAnchor.constraint(equalTo: testButton.topAnchor, constant: -40).isActive = true
        
        testButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        testButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        testButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        testButton.heightAnchor.constraint(equalTo: testButton.widthAnchor, multiplier: 0.17).isActive = true
        
        testButtonLabel.centerYAnchor.constraint(equalTo: testButton.centerYAnchor).isActive = true
        testButtonLabel.centerXAnchor.constraint(equalTo: testButton.centerXAnchor).isActive = true
    }
}

//
//  MainViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 22.11.2024.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var slaveButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private lazy var slaveButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "ИСПОЛНИТЕЛЬ\n\nЯ хочу предоставить услугу по уходу за питомцем"
        label.textColor = .white
        return label
    }()
    private lazy var masterButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private lazy var masterButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "ЗАКАЗЧИК\n\nЯ нуждаюсь в услуге по уходу за питомцем"
        label.textColor = .white
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "PetLink"
        label.textColor = .systemTeal
        label.font = .italicSystemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        view.backgroundColor = .systemBackground
        view.addSubview(slaveButtonView)
        slaveButtonView.addSubview(slaveButtonLabel)
        slaveButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(slaveTapped)))
        view.addSubview(masterButtonView)
        masterButtonView.addSubview(masterButtonLabel)
        masterButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(masterTapped)))
        view.addSubview(titleLabel)
        setupConstraints()
    }
    @objc
    private func slaveTapped() {
        toSevices(modeSlaveMaster: .slave)
    }
    @objc
    private func masterTapped() {
        toSevices(modeSlaveMaster: .master)
    }
    private func toSevices(modeSlaveMaster: ServiceModel.Mode) {
        let targetButtonView: UIView
        let targetButtonLabel: UILabel
        switch modeSlaveMaster {
        case .master:
            targetButtonView = self.masterButtonView
            targetButtonLabel = self.masterButtonLabel
        case .slave:
            targetButtonView = self.slaveButtonView
            targetButtonLabel = self.slaveButtonLabel
            
        }
        self.masterButtonView.isUserInteractionEnabled = false
        self.slaveButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            targetButtonView.layer.opacity = 0.9
            targetButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            targetButtonLabel.layer.opacity = 0.95
            targetButtonLabel.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                targetButtonView.layer.opacity = 1
                targetButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                targetButtonLabel.layer.opacity = 1
                targetButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
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
                                viewController.modeSlaveMaster = modeSlaveMaster
                                self.navigationController?.pushViewController(viewController, animated: true)
                                self.masterButtonView.isUserInteractionEnabled = true
                                self.slaveButtonView.isUserInteractionEnabled = true
                                ServicesModel.shared.isLoaded = true
                            case .failure(let failure):
                                self.masterButtonView.isUserInteractionEnabled = true
                                self.slaveButtonView.isUserInteractionEnabled = true
                            }
                        }
                    }
                } else {
                    let viewController = ServicesViewController()
                    viewController.modeSlaveMaster = modeSlaveMaster
                    self.navigationController?.pushViewController(viewController, animated: true)
                    self.masterButtonView.isUserInteractionEnabled = true
                    self.slaveButtonView.isUserInteractionEnabled = true
                }
            }
        }
    }

}
extension MainViewController {
    private func setupConstraints() {
        slaveButtonView.translatesAutoresizingMaskIntoConstraints = false
        slaveButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        masterButtonView.translatesAutoresizingMaskIntoConstraints = false
        masterButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        slaveButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        slaveButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        slaveButtonView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: -20).isActive = true
        slaveButtonView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        
        masterButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        masterButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        masterButtonView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: -20).isActive = true
        masterButtonView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        
        slaveButtonLabel.topAnchor.constraint(equalTo: slaveButtonView.topAnchor, constant: 5).isActive = true
        slaveButtonLabel.bottomAnchor.constraint(equalTo: slaveButtonView.bottomAnchor, constant: -5).isActive = true
        slaveButtonLabel.leadingAnchor.constraint(equalTo: slaveButtonView.leadingAnchor, constant: 5).isActive = true
        slaveButtonLabel.trailingAnchor.constraint(equalTo: slaveButtonView.trailingAnchor, constant: -5).isActive = true
        
        masterButtonLabel.topAnchor.constraint(equalTo: masterButtonView.topAnchor, constant: 5).isActive = true
        masterButtonLabel.bottomAnchor.constraint(equalTo: masterButtonView.bottomAnchor, constant: -5).isActive = true
        masterButtonLabel.leadingAnchor.constraint(equalTo: masterButtonView.leadingAnchor, constant: 5).isActive = true
        masterButtonLabel.trailingAnchor.constraint(equalTo: masterButtonView.trailingAnchor, constant: -5).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: masterButtonLabel.bottomAnchor, constant: 110).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}

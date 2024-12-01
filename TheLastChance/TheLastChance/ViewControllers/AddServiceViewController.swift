//
//  AddServiceViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

final class AddServiceViewController: UIViewController {

    var petsModel: PetsModel = PetsModel()
    var serviceAddModel = ServiceAddModel()
    weak var servicesViewController: ServicesViewController?
    private var collectionHeight0Constraint = NSLayoutConstraint()
    private var collectionHeight1Constraint = NSLayoutConstraint()
    private var addHeight0Constraint = NSLayoutConstraint()
    private var addHeight1Constraint = NSLayoutConstraint()
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var segmentedControlView: SegmentedControlView = SegmentedControlView()
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemTeal
        return imageView
    }()
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        label.text = "Вы можете поделиться здесь профилями питомцев с исполнителем:"
        label.numberOfLines = 0
        return label
    }()
    private var collectionView: UICollectionView!
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
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Заголовок:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Описание:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemTeal.cgColor
        textView.layer.borderWidth = 1.0
        textView.font = .italicSystemFont(ofSize: 16)
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.tintColor = .systemTeal
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .go
        return textView
    }()
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemTeal.cgColor
        textView.layer.borderWidth = 1.0
        textView.font = .italicSystemFont(ofSize: 16)
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.tintColor = .systemTeal
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .go
        return textView
    }()
    private lazy var saveButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemTeal
        return view
    }()
    private lazy var saveButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Сохранить"
        label.textColor = .white
        return label
    }()
    private var keyboardUpDownConstraints: NSLayoutConstraint = NSLayoutConstraint()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(segmentedControlView)
        segmentedControlView.setup(delegate: self)
        contentView.addSubview(photoImageView)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.identifier)
        contentView.addSubview(addLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(separator0View)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(separator1View)
        contentView.addSubview(saveButtonView)
        saveButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(save)))
        saveButtonView.addSubview(saveButtonLabel)
        contentView.addSubview(separator2View)
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        setupConstraints()
        getUser()
        setupKeyboardObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.bounds.width / 2
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            if titleTextView.isFirstResponder {
                scrollView.scrollRectToVisible(titleTextView.frame, animated: true)
            } else if descriptionTextView.isFirstResponder {
                scrollView.scrollRectToVisible(descriptionTextView.frame, animated: true)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    private func getUser() {
        DispatchQueue.main.async {
            if let icon = UserHostProfileModel.shared.userImage  {
                self.photoImageView.image = UIImage(data: icon)
            } else {
                self.photoImageView.image = nil
            }
        }
    }
    private func getPets(completion: @escaping ()-> Void) {
        if self.petsModel.pets.isEmpty {
            let dispatchGroup = DispatchGroup()
            DataManager.shared.getPets(userId: Settings.shared.userId) { resultPetIds in
                switch resultPetIds {
                case .success(let successPetIds):
                    for petId in successPetIds.petIds {
                        if !self.petsModel.pets.contains(where: { $0.petId == petId}) {
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
                    }
                    dispatchGroup.notify(queue: .main) {
                        completion()
                    }
                case .failure(let failurePetIds):
                    print("[ERROR]: \(failurePetIds.message())")
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    @objc
    private func save() {
        guard let servicesViewController = servicesViewController else { return }
        saveButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.saveButtonView.layer.opacity = 0.9
            self.saveButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.saveButtonLabel.layer.opacity = 0.9
            self.saveButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.saveButtonView.layer.opacity = 1
                self.saveButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.saveButtonLabel.layer.opacity = 1
                self.saveButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                let serviceModel = ServiceModel(
                    role: self.serviceAddModel.role,
                    serviceId: "",
                    userId: UserHostProfileModel.shared.userId,
                    title: self.serviceAddModel.title,
                    description: self.serviceAddModel.description,
                    userImageData: PhotoHelper.getImageBase64String(imageData: UserHostProfileModel.shared.userImage),
                    petIds: self.serviceAddModel.petIds)
                DataManager.shared.addService(serviceModel: serviceModel) { result in
                    switch result {
                    case .success(let success):
                        print(#function)
                        switch success.role {
                        case .master:
                            ServicesModel.shared.servicesMaster.append(success)
                        case .slave:
                            ServicesModel.shared.servicesSlave.append(success)
                        }
                        servicesViewController.reloadCollection()
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let failure):
                        break
                    }
                    self.saveButtonView.isUserInteractionEnabled = true
                }
            }
        }
    }
}
extension AddServiceViewController: SegmentedControlDelegate {
    func segmentedControleSet(role: ServiceModel.Mode) {
        print(#function)
        print("role.rawValue = \(role.rawValue)")
        serviceAddModel.role = role
        getPets {
            self.collectionHeight0Constraint.priority = UILayoutPriority(self.serviceAddModel.role == .master ? 750 : 950)
            self.collectionHeight1Constraint.priority = UILayoutPriority(self.serviceAddModel.role == .master ? 950 : 750)
            self.addHeight0Constraint.priority = UILayoutPriority(self.serviceAddModel.role == .master ? 750 : 950)
            self.addHeight1Constraint.priority = UILayoutPriority(self.serviceAddModel.role == .master ? 950 : 750)
            self.addLabel.isHidden = self.serviceAddModel.role == .slave
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.collectionView.reloadData()
            }
        }
    }
}
extension AddServiceViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == titleTextView {
            print(text)
            serviceAddModel.title = text
        }
        if textView == descriptionTextView {
            print(text)
            serviceAddModel.description = text
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
extension AddServiceViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        saveButtonView.translatesAutoresizingMaskIntoConstraints = false
        saveButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        segmentedControlView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        segmentedControlView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        segmentedControlView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        segmentedControlView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: segmentedControlView.bottomAnchor, constant: 30).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor).isActive = true
        
        addLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10).isActive = true
        addLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        addLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        addHeight0Constraint = NSLayoutConstraint(item: addLabel as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
        addHeight1Constraint = NSLayoutConstraint(item: addLabel as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 34.0)
        addHeight0Constraint.priority = UILayoutPriority(serviceAddModel.role == .master ? 750 : 950)
        addHeight1Constraint.priority = UILayoutPriority(serviceAddModel.role == .master ? 950 : 750)
        addHeight0Constraint.isActive = true
        addHeight1Constraint.isActive = true
        
        collectionView.topAnchor.constraint(equalTo: addLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

        collectionHeight0Constraint = NSLayoutConstraint(item: collectionView as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
        collectionHeight1Constraint = NSLayoutConstraint(item: collectionView as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0)
        collectionHeight0Constraint.priority = UILayoutPriority(serviceAddModel.role == .master ? 750 : 950)
        collectionHeight1Constraint.priority = UILayoutPriority(serviceAddModel.role == .master ? 950 : 750)
        collectionHeight0Constraint.isActive = true
        collectionHeight1Constraint.isActive = true

        separator0View.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 3).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        saveButtonView.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 30).isActive = true
        saveButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        saveButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        saveButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
        saveButtonLabel.centerYAnchor.constraint(equalTo: saveButtonView.centerYAnchor).isActive = true
        saveButtonLabel.centerXAnchor.constraint(equalTo: saveButtonView.centerXAnchor).isActive = true
    }
}
extension AddServiceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return serviceAddModel.role == .master ? CGSize(width: 100, height: 150) : CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let petModel = petsModel.pets[indexPath.row]
        print("Выбрано животное: \(petModel.petName) из типа: \(petModel.typeOfAnimal) petId: \(String(describing: petModel.petId))")
        if let cell = collectionView.cellForItem(at: indexPath) as? PetCollectionViewCell {
            if let index = serviceAddModel.petIds.firstIndex(where: { petModel.petId == $0 }) {
                cell.setup(isMarked: false)
                serviceAddModel.petIds.remove(at: index)
            } else {
                //let sep: String = descriptionTextView.text.isEmpty ? "" : " "
                //descriptionTextView.text = descriptionTextView.text + sep + petModel.typeOfAnimal + " " + petModel.petName + " "
                cell.setup(isMarked: true)
                serviceAddModel.petIds.append(petModel.petId)
            }
            print("serviceModel.petIds: \(serviceAddModel.petIds)")
        }
    }
    
}

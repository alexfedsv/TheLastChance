//
//  EditPetViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 17.12.2024.
//

import UIKit

final class EditPetViewController: BaseViewController {

    var userModel: UserProfileModel?
    var petModel: PetProfileModel?
    weak var userViewController: UserHostProfileViewController?
    weak var petViewController: PetProfileViewController?
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private let imagePicker = UIImagePickerController()

    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var petPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemTeal
        return imageView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
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
        label.font = .systemFont(ofSize: 14)
        label.text = "Вид питомца:"
        label.numberOfLines = 0
        return label
    }()
    private lazy var petnameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Имя питомца:"
        label.numberOfLines = 0
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Дополнительная информация:"
        label.numberOfLines = 0
        return label
    }()
    private lazy var typeOfAnimalTextView: UITextView = {
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
    private lazy var petnameTextView: UITextView = {
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
    private lazy var infoTextView: UITextView = {
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
    private lazy var removeButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemOrange
        return view
    }()
    private lazy var removeButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Удалить"
        label.textColor = .white
        return label
    }()
    private var keyboardUpDownConstraints: NSLayoutConstraint = NSLayoutConstraint()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(petPhotoImageView)
        petPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPetImage)))
        petPhotoImageView.addSubview(activityIndicator)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(typeOfAnimalLabel)
        view.addSubview(typeOfAnimalTextView)
        view.addSubview(petnameLabel)
        view.addSubview(petnameTextView)
        view.addSubview(separator1View)
        view.addSubview(saveButtonView)
        saveButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(savePet)))
        saveButtonView.addSubview(saveButtonLabel)
        view.addSubview(removeButtonView)
        removeButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removePet)))
        removeButtonView.addSubview(removeButtonLabel)
        view.backgroundColor = .systemBackground
        view.addSubview(infoLabel)
        view.addSubview(infoTextView)
        view.addSubview(separator2View)
        typeOfAnimalTextView.delegate = self
        petnameTextView.delegate = self
        infoTextView.delegate = self
        setupConstraints()
        setupData()
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
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width / 2
        petPhotoImageView.layer.cornerRadius = petPhotoImageView.bounds.width / 2
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            if typeOfAnimalTextView.isFirstResponder {
                scrollView.scrollRectToVisible(typeOfAnimalTextView.frame, animated: true)
            } else if petnameTextView.isFirstResponder {
                scrollView.scrollRectToVisible(petnameTextView.frame, animated: true)
            }
            else if infoTextView.isFirstResponder {
               scrollView.scrollRectToVisible(infoTextView.frame, animated: true)
           }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    private func setupData() {
        if let petModel = petModel {
            DispatchQueue.main.async {
                if let data = petModel.petAvatar, let icon = UIImage(data: data) {
                    self.petPhotoImageView.image = icon
                } else {
                    self.petPhotoImageView.image = UIImage(systemName: "plus.circle")
                }
                self.typeOfAnimalTextView.text = petModel.typeOfAnimal
                self.petnameTextView.text = petModel.petName
                self.infoTextView.text = petModel.info
            }
        }
        guard let userModel = userModel else { return }
        DispatchQueue.main.async {
            if let icon = userModel.userImage  {
                self.userPhotoImageView.image = UIImage(data: icon)
            } else {
                self.userPhotoImageView.image = nil
            }
        }
    }
    @objc
    private func addPetImage() {
        print(#function)
        present(imagePicker, animated: true, completion: nil)
    }
    @objc
    private func savePet() {
        guard let userViewController = userViewController else { return }
        guard let petViewController = petViewController else { return }
        guard let petModel = petModel else { return }
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
                DataManager.shared.editPet(petProfileModel: petModel) { err in
                    DispatchQueue.main.async {
                        if err == nil {
                            if let index = userViewController.petsModel.pets.firstIndex(where: { $0.petId == petModel.petId }) {
                                userViewController.petsModel.pets[index].typeOfAnimal = petModel.typeOfAnimal
                                userViewController.petsModel.pets[index].petName = petModel.petName
                                userViewController.petsModel.pets[index].info = petModel.info
                                userViewController.petsModel.pets[index].petAvatar = petModel.petAvatar
                                userViewController.reloadCollection()
                                petViewController.renewPetProfile(petProfileEdited: petModel)
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                self.saveButtonView.isUserInteractionEnabled = true
                            }
                        } else {
                            self.saveButtonView.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
    }
    @objc
    private func removePet() {
        guard let userViewController = userViewController else { return }
        guard let petModel = petModel else { return }
        guard let navigationController = self.navigationController else { return }
        if petModel.petAvatar != nil {
            activityIndicator.startAnimating()
        }
        removeButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.removeButtonView.layer.opacity = 0.9
            self.removeButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.removeButtonLabel.layer.opacity = 0.9
            self.removeButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.removeButtonView.layer.opacity = 1
                self.removeButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.removeButtonLabel.layer.opacity = 1
                self.removeButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                DataManager.shared.deletePet(petId: petModel.petId) { err in
                    if err == nil {
                        DispatchQueue.main.async {
                            if let index = userViewController.petsModel.pets.firstIndex(where: { $0.petId == petModel.petId }) {
                                userViewController.petsModel.pets.remove(at: index)
                                userViewController.reloadCollection()
                                var viewControllers = navigationController.viewControllers
                                if viewControllers.count > 1 {
                                    viewControllers.remove(at: viewControllers.count - 2)
                                    navigationController.setViewControllers(viewControllers, animated: true)
                                    navigationController.popViewController(animated: true)
                                } else {
                                    self.removeButtonView.isUserInteractionEnabled = true
                                }
                            } else {
                                self.removeButtonView.isUserInteractionEnabled = true
                            }
                        }
                    } else {
                        self.removeButtonView.isUserInteractionEnabled = true
                    }
                    if petModel.petAvatar != nil {
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}
extension EditPetViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == typeOfAnimalTextView {
            petModel?.typeOfAnimal = text
        }
        if textView == petnameTextView {
            print(text)
            petModel?.petName = text
        }
        if textView == infoTextView {
            print(text)
            petModel?.info = text
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
extension EditPetViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        petPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        separator0View.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalLabel.translatesAutoresizingMaskIntoConstraints = false
        typeOfAnimalTextView.translatesAutoresizingMaskIntoConstraints = false
        petnameLabel.translatesAutoresizingMaskIntoConstraints = false
        petnameTextView.translatesAutoresizingMaskIntoConstraints = false
        separator1View.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        separator2View.translatesAutoresizingMaskIntoConstraints = false
        saveButtonView.translatesAutoresizingMaskIntoConstraints = false
        saveButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        removeButtonView.translatesAutoresizingMaskIntoConstraints = false
        removeButtonLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        petPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        petPhotoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        petPhotoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        petPhotoImageView.heightAnchor.constraint(equalTo: petPhotoImageView.widthAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: petPhotoImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: petPhotoImageView.centerYAnchor).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor).isActive = true
        userPhotoImageView.leadingAnchor.constraint(equalTo: petPhotoImageView.trailingAnchor, constant: -30).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor, constant: 20).isActive = true
        separator0View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator0View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator0View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        typeOfAnimalLabel.topAnchor.constraint(equalTo: separator0View.bottomAnchor, constant: 15).isActive = true
        typeOfAnimalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        typeOfAnimalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        typeOfAnimalTextView.topAnchor.constraint(equalTo: typeOfAnimalLabel.bottomAnchor, constant: 3).isActive = true
        typeOfAnimalTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        typeOfAnimalTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        typeOfAnimalTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        petnameLabel.topAnchor.constraint(equalTo: typeOfAnimalTextView.bottomAnchor, constant: 5).isActive = true
        petnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        petnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        petnameTextView.topAnchor.constraint(equalTo: petnameLabel.bottomAnchor, constant: 3).isActive = true
        petnameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        petnameTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        petnameTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
        separator1View.topAnchor.constraint(equalTo: petnameTextView.bottomAnchor, constant: 15).isActive = true
        separator1View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator1View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator1View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: separator1View.bottomAnchor, constant: 10).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        infoTextView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 3).isActive = true
        infoTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        infoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        infoTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        
        separator2View.topAnchor.constraint(equalTo: infoTextView.bottomAnchor, constant: 15).isActive = true
        separator2View.bottomAnchor.constraint(equalTo: saveButtonView.topAnchor, constant: -15).isActive = true
        separator2View.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        separator2View.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        separator2View.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        saveButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        saveButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        saveButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButtonView.bottomAnchor.constraint(equalTo: removeButtonView.topAnchor, constant: -10).isActive = true
        
        saveButtonLabel.centerYAnchor.constraint(equalTo: saveButtonView.centerYAnchor).isActive = true
        saveButtonLabel.centerXAnchor.constraint(equalTo: saveButtonView.centerXAnchor).isActive = true
        
        removeButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        removeButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        removeButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        removeButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        removeButtonLabel.centerYAnchor.constraint(equalTo: removeButtonView.centerYAnchor).isActive = true
        removeButtonLabel.centerXAnchor.constraint(equalTo: removeButtonView.centerXAnchor).isActive = true
    }
}
extension EditPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func getAvatarIcon(pickedImageEdited: UIImage) -> Data? {
        if let imageData = pickedImageEdited.jpegData(compressionQuality: 0.3) {
            let imageSize = imageData.count
            print("Размер изображения в байтах[compressionQuality: \(0.3)] = \(imageSize)")
            return imageData
        } else {
            return nil
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var iconData: Data?
        if let pickedImageEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if let data = getAvatarIcon(pickedImageEdited: pickedImageEdited) {
                iconData = data
            }
        }
        guard let iconData = iconData else { return }

        DispatchQueue.main.async {
            if let image = UIImage(data: iconData) {
                self.petPhotoImageView.image = image
                self.petModel?.petAvatar = iconData
            } else {
                print("ERROR[\(#function)]: Cannot converte Data to UIImage")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


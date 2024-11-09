//
//  AddEditPetViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 31.10.2024.
//

import UIKit

final class AddEditPetViewController: UIViewController {

    var userModel: UserProfileModel?
    var petModel: PetProfileModel?
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()

    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private lazy var petPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemTeal
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
    private var keyboardUpDownConstraints: NSLayoutConstraint = NSLayoutConstraint()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(petPhotoImageView)
        view.addSubview(userPhotoImageView)
        view.addSubview(separator0View)
        view.addSubview(typeOfAnimalLabel)
        view.addSubview(typeOfAnimalTextView)
        view.addSubview(petnameLabel)
        view.addSubview(petnameTextView)
        view.addSubview(separator1View)
        view.addSubview(saveButtonView)
        saveButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(save)))
        saveButtonView.addSubview(saveButtonLabel)
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
                if let icon = petModel.petAvatar  {
                    self.petPhotoImageView.image = UIImage(data: icon)
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
    private func save() {
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
                DataManager.shared.getUserProfile(userId: 1) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            print(#function)
                            break
                        case .failure(let failure):
                            break
                        }
                        self.saveButtonView.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
}
extension AddEditPetViewController: UITextViewDelegate {
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
extension AddEditPetViewController {
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        petPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
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

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        petPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        petPhotoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        petPhotoImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        petPhotoImageView.heightAnchor.constraint(equalTo: petPhotoImageView.widthAnchor).isActive = true
        
        userPhotoImageView.bottomAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor).isActive = true
        userPhotoImageView.leadingAnchor.constraint(equalTo: petPhotoImageView.trailingAnchor, constant: -30).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalTo: userPhotoImageView.widthAnchor).isActive = true
        
        separator0View.topAnchor.constraint(equalTo: petPhotoImageView.bottomAnchor, constant: 30).isActive = true
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
        saveButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
        saveButtonLabel.centerYAnchor.constraint(equalTo: saveButtonView.centerYAnchor).isActive = true
        saveButtonLabel.centerXAnchor.constraint(equalTo: saveButtonView.centerXAnchor).isActive = true
    }
}


//
//  AddServiceViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 06.11.2024.
//

import UIKit

final class AddServiceViewController: UIViewController {

    var userModel: UserProfileModel?
    var serviceModel = ServiceModel(userId: 1, title: "", description: "", userImageData: "", petImageData: "")
    
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
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Описание:"
        label.numberOfLines = 0
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
    private func setupData() {
        guard let userModel = userModel else { return }
        DispatchQueue.main.async {
            if let icon = userModel.userImage  {
                self.photoImageView.image = UIImage(data: icon)
            } else {
                self.photoImageView.image = nil
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
extension AddServiceViewController: SegmentedControlDelegate {
    func segmentedControleSet(mode: ServiceModel.Mode) {
        print(#function)
        serviceModel.mode = mode
    }
}
extension AddServiceViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == titleTextView {
            print(text)
            serviceModel.title = text
        }
        if textView == descriptionTextView {
            print(text)
            serviceModel.description = text
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

        separator0View.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 30).isActive = true
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



//
//  FilterViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 23.12.2024.
//

import UIKit

final class FilterViewController: BaseViewController {

    weak var servicesViewControllerDelegate: ServicesViewControllerDelegate?
    var words: [String] = []
    private var collectionView: UICollectionView!
    private lazy var minPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Минимальная цена:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var minPriceTailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "рублей"
        label.numberOfLines = 1
        return label
    }()
    private lazy var minPriceTextView: UITextView = {
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
        textView.keyboardType = .numberPad
        textView.text = String(FilterModel.shared.minPrice)
        return textView
    }()
    private lazy var maxPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Максимальная цена:"
        label.numberOfLines = 1
        return label
    }()
    private lazy var maxPriceTailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "рублей"
        label.numberOfLines = 1
        return label
    }()
    private lazy var maxPriceTextView: UITextView = {
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
        textView.keyboardType = .numberPad
        textView.text = String(FilterModel.shared.maxPrice)
        return textView
    }()
    private lazy var resetButtonView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemOrange
        return view
    }()
    private lazy var resetButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Очистить"
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        view.addSubview(collectionView)
        minPriceTextView.delegate = self
        maxPriceTextView.delegate = self
        view.addSubview(minPriceLabel)
        view.addSubview(minPriceTextView)
        view.addSubview(minPriceTailLabel)
        view.addSubview(maxPriceLabel)
        view.addSubview(maxPriceTextView)
        view.addSubview(maxPriceTailLabel)
        view.addSubview(resetButtonView)
        resetButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reset)))
        resetButtonView.addSubview(resetButtonLabel)
        setupConstraints()
    }
    @objc
    private func reset() {
        guard let delegate = servicesViewControllerDelegate else { return }
        resetButtonView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.resetButtonView.layer.opacity = 0.9
            self.resetButtonView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.resetButtonLabel.layer.opacity = 0.9
            self.resetButtonLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.resetButtonView.layer.opacity = 1
                self.resetButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.resetButtonLabel.layer.opacity = 1
                self.resetButtonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                self.minPriceTextView.text = "0"
                self.maxPriceTextView.text = "0"
                FilterModel.shared.reset()
                delegate.applyFilters()
                self.collectionView.reloadData()
                self.resetButtonView.isUserInteractionEnabled = true
                //self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
extension FilterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == minPriceTextView {
            FilterModel.shared.minPrice = Int(text) ?? 0
        }
        if textView == maxPriceTextView {
            FilterModel.shared.maxPrice = Int(text) ?? 0
        }
        guard let delegate = servicesViewControllerDelegate else { return }
        delegate.applyFilters()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if textView == minPriceTextView {
            if text == "" {
                FilterModel.shared.minPrice = 0
                textView.text = "0"
            }
        }
        if textView == maxPriceTextView {
            if text == "" {
                FilterModel.shared.maxPrice = 0
                textView.text = "0"
            }
        }
        guard let delegate = servicesViewControllerDelegate else { return }
        delegate.applyFilters()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
extension FilterViewController {
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        minPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        minPriceTextView.translatesAutoresizingMaskIntoConstraints = false
        minPriceTailLabel.translatesAutoresizingMaskIntoConstraints = false
        maxPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        maxPriceTextView.translatesAutoresizingMaskIntoConstraints = false
        maxPriceTailLabel.translatesAutoresizingMaskIntoConstraints = false
        resetButtonView.translatesAutoresizingMaskIntoConstraints = false
        resetButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        minPriceLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40).isActive = true
        minPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        
        minPriceTextView.topAnchor.constraint(equalTo: minPriceLabel.bottomAnchor, constant: 5).isActive = true
        minPriceTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        minPriceTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -200).isActive = true
        minPriceTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        minPriceTailLabel.centerYAnchor.constraint(equalTo: minPriceTextView.centerYAnchor).isActive = true
        minPriceTailLabel.leadingAnchor.constraint(equalTo: minPriceTextView.trailingAnchor, constant: 10).isActive = true
        minPriceTailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        maxPriceLabel.topAnchor.constraint(equalTo: minPriceTextView.bottomAnchor, constant: 15).isActive = true
        maxPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        
        maxPriceTextView.topAnchor.constraint(equalTo: maxPriceLabel.bottomAnchor, constant: 5).isActive = true
        maxPriceTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        maxPriceTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -200).isActive = true
        maxPriceTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        maxPriceTailLabel.centerYAnchor.constraint(equalTo: maxPriceTextView.centerYAnchor).isActive = true
        maxPriceTailLabel.leadingAnchor.constraint(equalTo: maxPriceTextView.trailingAnchor, constant: 10).isActive = true
        maxPriceTailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        resetButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        resetButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        resetButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        resetButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        resetButtonLabel.centerYAnchor.constraint(equalTo: resetButtonView.centerYAnchor).isActive = true
        resetButtonLabel.centerXAnchor.constraint(equalTo: resetButtonView.centerXAnchor).isActive = true
    }
}
extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell {
            cell.mark(isMarked: FilterModel.shared.words.contains(where: { $0 == words[indexPath.row] }))
            cell.setup(title: words[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let att = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        let size = (words[indexPath.row] as NSString).size(withAttributes: att)
        return CGSize(width: size.width + 20, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
            let mark = cell.mark()
            if mark {
                FilterModel.shared.words.append(words[indexPath.row])
            } else {
                FilterModel.shared.words.removeAll(where: { $0 == words[indexPath.row] })
            }
            print(FilterModel.shared.words)
            guard let delegate = servicesViewControllerDelegate else { return }
            delegate.applyFilters()
        }
    }
}

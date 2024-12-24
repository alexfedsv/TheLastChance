//
//  ServicesViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import UIKit

protocol ServicesViewControllerDelegate: AnyObject {
    func setModeSlaveMaster(mode: ServiceModel.Mode)
    func applyFilters()
}

final class ServicesViewController: UIViewController {

    private var filterConstraint0 = NSLayoutConstraint()
    private var filterConstraint1 = NSLayoutConstraint()
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.barTintColor = .systemTeal
        bar.backgroundColor = .systemBackground
        bar.autocapitalizationType = .none
        bar.autocorrectionType = .no
        bar.spellCheckingType = .no
        bar.returnKeyType = .go
        bar.searchBarStyle = .minimal
        return bar
    }()
    private var isSearchOn = false
    private var isFilterOn = false
    private var collectionServicesView: UICollectionView!
    private var collectionFilterView: UICollectionView!
    var modeSlaveMaster: ServiceModel.Mode?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.addSubview(searchBar)
        searchBar.delegate = self
        view.backgroundColor = .systemBackground
        let layoutFilter = UICollectionViewFlowLayout()
        layoutFilter.scrollDirection = .horizontal
        layoutFilter.minimumLineSpacing = 3
        layoutFilter.minimumInteritemSpacing = 3
        collectionFilterView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layoutFilter)
        collectionFilterView.backgroundColor = .systemBackground
        collectionFilterView.dataSource = self
        collectionFilterView.delegate = self
        collectionFilterView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        view.addSubview(collectionFilterView)
        let layoutServices = UICollectionViewFlowLayout()
        layoutServices.scrollDirection = .vertical
        layoutServices.minimumLineSpacing = 10
        layoutServices.minimumInteritemSpacing = 10
        collectionServicesView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layoutServices)
        collectionServicesView.backgroundColor = .systemBackground
        collectionServicesView.dataSource = self
        collectionServicesView.delegate = self
        collectionServicesView.register(ServicesCollectionViewCell.self, forCellWithReuseIdentifier: ServicesCollectionViewCell.identifier)
        view.addSubview(collectionServicesView)
        setupConstraints()
        collectionServicesView.reloadData()
    }
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemTeal
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        let rightButtonImageFilter = UIImage(systemName: "slider.vertical.3")
        let rightBarButtonItemFilter = UIBarButtonItem(image: rightButtonImageFilter, style: .plain, target: self, action: #selector(filterButtonTapped))
        //let rightButtonImageMap = UIImage(systemName: "globe")
        //let rightBarButtonItemMap = UIBarButtonItem(image: rightButtonImageMap, style: .plain, target: self, action: #selector(mapButtonTapped))
        let rightButtonImageAdd = UIImage(systemName: "plus")
        let rightBarButtonItemAdd = UIBarButtonItem(image: rightButtonImageAdd, style: .plain, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItems = [rightBarButtonItemAdd, rightBarButtonItemFilter]
        
    }
    @objc
    private func filterButtonTapped() {
        print(#function)
        DispatchQueue.main.async {
            DataManager.shared.getWordsForFilter { strings in
                let viewController = FilterViewController()
                viewController.servicesViewControllerDelegate = self
                viewController.words = strings.map({ $0 })
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    @objc
    private func mapButtonTapped() {
        print(#function)
    }
    @objc
    private func addButtonTapped() {
        if Settings.shared.userId == "" {
            if let tabBarController = self.tabBarController {
                if let viewControllers = tabBarController.viewControllers,
                    viewControllers.count > 0 {
                    tabBarController.selectedViewController = viewControllers[1]
                }
            }
        } else {
            let viewController = AddServiceViewController()
            viewController.servicesViewController = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionServicesView.reloadData()
        }
    }
}
extension ServicesViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange: String) {
        guard let modeSlaveMaster = modeSlaveMaster else { return }
        print(textDidChange)
        if textDidChange.isEmpty {
            isSearchOn = false
            switch modeSlaveMaster {
            case .master:
                ServicesModel.shared.servicesMasterSearch = []
            case .slave:
                ServicesModel.shared.servicesSlaveSearch = []
            }
        } else {
            isSearchOn = true
            switch modeSlaveMaster {
            case .master:
                ServicesModel.shared.servicesMasterSearch = ServicesModel.shared.servicesMaster.filter { service in
                    service.title.lowercased().contains(textDidChange.lowercased()) ||
                    service.description.lowercased().contains(textDidChange.lowercased())
                }
            case .slave:
                ServicesModel.shared.servicesSlaveSearch = ServicesModel.shared.servicesSlave.filter { service in
                    service.title.lowercased().contains(textDidChange.lowercased()) ||
                    service.description.lowercased().contains(textDidChange.lowercased())
                }
            }
        }
        collectionServicesView.reloadData()
    }
    func searchBarTextDidEndEditing(_: UISearchBar) {
        
    }
}
extension ServicesViewController: ServicesViewControllerDelegate {
    func applyFilters() {
        print(#function)
        DataManager.shared.getFilteredServices() { err in
            DispatchQueue.main.async {
                if err == nil && !FilterModel.shared.servicesFiltered.isEmpty {
                    DispatchQueue.main.async {
                        self.filterConstraint0.priority = UILayoutPriority(rawValue: 750)
                        self.filterConstraint1.priority = UILayoutPriority(rawValue: 950)
                        self.isFilterOn = true
                        self.collectionFilterView.reloadData()
                        self.collectionServicesView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.filterConstraint0.priority = UILayoutPriority(rawValue: 950)
                        self.filterConstraint1.priority = UILayoutPriority(rawValue: 750)
                        self.isFilterOn = false
                        self.collectionFilterView.reloadData()
                        self.collectionServicesView.reloadData()
                    }
                }
            }
        }
        
    }
    func setModeSlaveMaster(mode: ServiceModel.Mode) {
        self.modeSlaveMaster = mode
        DispatchQueue.main.async {
            self.collectionServicesView.reloadData()
        }
    }
}
extension ServicesViewController {
    private func setupConstraints() {
        collectionFilterView.translatesAutoresizingMaskIntoConstraints = false
        collectionServicesView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        collectionFilterView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        collectionFilterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionFilterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        collectionServicesView.topAnchor.constraint(equalTo: collectionFilterView.bottomAnchor, constant: 5).isActive = true
        collectionServicesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionServicesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionServicesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        filterConstraint0 = NSLayoutConstraint(item: collectionFilterView as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        filterConstraint0.priority = UILayoutPriority(rawValue: 950)
        filterConstraint0.isActive = true
        
        filterConstraint1 = NSLayoutConstraint(item: collectionFilterView as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        filterConstraint1.priority = UILayoutPriority(rawValue: 750)
        filterConstraint1.isActive = true
    }
}
extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionServicesView {
            guard let modeSlaveMaster = modeSlaveMaster else { return 0 }
            if isFilterOn {
                return FilterModel.shared.servicesFiltered.count
            } else {
                switch modeSlaveMaster {
                case .master:
                    if isSearchOn {
                        return ServicesModel.shared.servicesMasterSearch.count
                    } else {
                        return ServicesModel.shared.servicesMaster.count
                    }
                case .slave:
                    if isSearchOn {
                        return ServicesModel.shared.servicesSlaveSearch.count
                    } else {
                        return ServicesModel.shared.servicesSlave.count
                    }
                }
            }
        } else if collectionView == collectionFilterView {
            if isFilterOn {
                return FilterModel.shared.words.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let modeSlaveMaster = modeSlaveMaster else { return UICollectionViewCell() }
        if isFilterOn {
            if collectionView == collectionServicesView {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as? ServicesCollectionViewCell {
                    cell.setup(title: FilterModel.shared.servicesFiltered[indexPath.row].title,
                               description: FilterModel.shared.servicesFiltered[indexPath.row].description,
                               imageData: FilterModel.shared.servicesFiltered[indexPath.row].userImageData)
                    return cell
                }
            } else if collectionView == collectionFilterView {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell {
                    cell.setup(title: String(indexPath.row))
                    return cell
                }
            } else {
                print("[ERROR][\(#function)][1]")
                return UICollectionViewCell()
            }
        } else {
            if collectionView == collectionServicesView {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for: indexPath) as? ServicesCollectionViewCell {
                    switch modeSlaveMaster {
                    case .master:
                        if isSearchOn {
                            cell.setup(title: ServicesModel.shared.servicesMasterSearch[indexPath.row].title,
                                       description: ServicesModel.shared.servicesMasterSearch[indexPath.row].description,
                                       imageData: ServicesModel.shared.servicesMasterSearch[indexPath.row].userImageData)
                        } else {
                            cell.setup(title: ServicesModel.shared.servicesMaster[indexPath.row].title,
                                       description: ServicesModel.shared.servicesMaster[indexPath.row].description,
                                       imageData: ServicesModel.shared.servicesMaster[indexPath.row].userImageData)
                        }
                    case .slave:
                        if isSearchOn {
                            cell.setup(title: ServicesModel.shared.servicesSlaveSearch[indexPath.row].title,
                                       description: ServicesModel.shared.servicesSlaveSearch[indexPath.row].description,
                                       imageData: ServicesModel.shared.servicesSlaveSearch[indexPath.row].userImageData)
                        } else {
                            cell.setup(title: ServicesModel.shared.servicesSlave[indexPath.row].title,
                                       description: ServicesModel.shared.servicesSlave[indexPath.row].description,
                                       imageData: ServicesModel.shared.servicesSlave[indexPath.row].userImageData)
                        }
                    }
                    return cell
                }
            } else if collectionView == collectionFilterView {
                print("[ERROR][\(#function)][2]")
                return UICollectionViewCell()
            } else {
                print("[ERROR][\(#function)][3]")
                return UICollectionViewCell()
            }
        }
        print("[ERROR][\(#function)][4]")
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionServicesView {
            return CGSize(width: collectionView.bounds.width, height: 70)
        } else {
            let att = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
            let size = ("tmp" as NSString).size(withAttributes: att)
            return CGSize(width: size.width + 20, height: 30)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionServicesView {
            guard let modeSlaveMaster = modeSlaveMaster else { return }
            let viewController = ServiceViewController()
            var userId: String
            var serviceModel: ServiceModel
            switch modeSlaveMaster {
            case .master:
                if isSearchOn{
                    userId = ServicesModel.shared.servicesMasterSearch[indexPath.row].userId
                    serviceModel = ServicesModel.shared.servicesMasterSearch[indexPath.row]
                } else {
                    userId = ServicesModel.shared.servicesMaster[indexPath.row].userId
                    serviceModel = ServicesModel.shared.servicesMaster[indexPath.row]
                }
            case .slave:
                if isSearchOn{
                    userId = ServicesModel.shared.servicesSlaveSearch[indexPath.row].userId
                    serviceModel = ServicesModel.shared.servicesSlaveSearch[indexPath.row]
                } else {
                    userId = ServicesModel.shared.servicesSlave[indexPath.row].userId
                    serviceModel = ServicesModel.shared.servicesSlave[indexPath.row]
                }
            }
            DataManager.shared.getUserProfile(userId: userId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        DispatchQueue.main.async {
                            let userModel = UserOtherProfileModel()
                            userModel.setup(userId: userId, json: success)
                            viewController.userModel = userModel
                            viewController.serviceModel = serviceModel
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    case .failure(let failure):
                        break
                    }
                }
            }
        } else {
            print("filter tapped")
        }
    }
}

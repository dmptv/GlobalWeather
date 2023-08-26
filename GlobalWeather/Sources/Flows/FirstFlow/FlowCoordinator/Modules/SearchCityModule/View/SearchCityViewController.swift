//
//  SearchCityViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import UIKit
import Combine

class SearchCityViewController: BaseViewController {
    var output: SearchCityViewOutput?
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: SearchTableView!
    @IBOutlet private weak var cancelImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: - Configure
extension SearchCityViewController: SearchCityViewInput, SearchTableViewDelegate {
    func didSelectTableViewRow(at indexPath: IndexPath) {
        output?.didSelectTableViewRow(at: indexPath)
    }
    
    private func setupSubviews() {
        setupNavigationBar()
        searchBar.delegate = self
        searchTableView.searchDelegate = self
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            let placeholderText = " Enter city, zip, code, or airport location"
            let placeholderAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0),
                .font: UIFont.systemFont(ofSize: 14)
            ]
            
            let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
            textField.attributedPlaceholder = attributedPlaceholder
            textField.textColor = UIColor.white
        }
        
        let sunriseBackgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0).cgColor
        let sunsetBackgroundColor = UIColor(red: 0.8, green: 0.3, blue: 0.6, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [sunriseBackgroundColor, sunsetBackgroundColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        cancelImage.layer.cornerRadius = cancelImage.frame.height / 2
        cancelImage.image = UIImage(named: "GhostEmoji")
    }
    
    private func setupNavigationBar() {
        let exitBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left") ?? UIImage(),
                                                style: .done,
                                                target: self,
                                                action: #selector(exitButtonTapped))
        navigationItem.leftBarButtonItem = exitBarButtonItem
    }
    
}

// MARK: View Input
extension SearchCityViewController {
    func updateSearchResults(_ results: [String]) {
        Just(results)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] results in
                self?.cancelImage.isHidden = true
                self?.searchTableView.searchResults = results
            }
            .store(in: &cancellables)
    }
    
    func showCancelImage() {
        DispatchQueue.main.async {
            self.cancelImage.isHidden = false
        }
    }
}

// MARK: Button Action
extension SearchCityViewController {
    @objc
    private func exitButtonTapped() {
        output?.backButtonAction()
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.textDidChange(searchText: searchText)?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.searchTableView.searchResults.removeAll()
            }
            .store(in: &cancellables)
    }
}



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
                self?.searchTableView.searchResults = results
            }
            .store(in: &cancellables)
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

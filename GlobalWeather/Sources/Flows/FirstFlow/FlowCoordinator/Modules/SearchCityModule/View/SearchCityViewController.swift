//
//  SearchCityViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import UIKit

class SearchCityViewController: BaseViewController {
    var output: SearchCityViewOutput?
    
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
        
    }
}

// MARK: - Configure
extension SearchCityViewController: SearchCityViewInput {
    private func setupSubviews() {
        setupNavigationBar()
        searchBar.delegate = self
        
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
//        presenter?.textDidChange(searchText: searchText)
    }
}

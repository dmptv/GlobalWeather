//
//  SearchTableView.swift
//  GlobalWeather
//
//  Created by Kanat on 25.08.2023.
//

import UIKit

class SearchTableView: UITableView {
    var searchResults = [String]()

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}

extension SearchTableView {
    private func setupViews() {
        dataSource = self
        delegate = self
        register(cellType: UITableViewCell.self)
    }
}

extension SearchTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults = ["first", "paris", "london"]
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UITableViewCell.self)
//        presenter?.configureCell(cell, forRowAt: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.didSelectTableViewRow(at: indexPath)
    }
}

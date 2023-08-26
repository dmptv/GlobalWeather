//
//  SearchTableView.swift
//  GlobalWeather
//
//  Created by Kanat on 25.08.2023.
//

import UIKit

protocol SearchTableViewDelegate: AnyObject {
    func didSelectTableViewRow(at indexPath: IndexPath)
}

class SearchTableView: UITableView {
    weak var searchDelegate: SearchTableViewDelegate?

    var searchResults = [String]() {
        didSet {
            reloadData()
        }
    }

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
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UITableViewCell.self)
        cell.backgroundColor = .clear
        cell.textLabel?.text = searchResults[indexPath.row]
        cell.textLabel?.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchDelegate?.didSelectTableViewRow(at: indexPath)
    }
}

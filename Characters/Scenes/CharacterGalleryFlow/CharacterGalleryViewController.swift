//
//  CharacterGalleryViewController.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class CharacterGalleryViewController: UIViewController, CharacterGalleryView {
    
    @IBOutlet var tableView: UITableView!
    
    var searchController: UISearchController!
    
    var presenter: CharacterGalleryViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpSearchController()
        navigationItem.title = presenter.navigationTitle
        presenter.viewDidLoad()
        
    }
    
    func showLoaderSpinner() {
        MBProgressHUD.showAdded(to:view, animated: true)
    }
    
    func hideLoaderSpinner() {
        DispatchQueue.main.async {  [weak self] in
            guard let `self` = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func updateTable() {
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.presenter.isFilterActive = self.searchController.isActive && self.searchController.searchBar.text != ""
            self.tableView.reloadData()
        }
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(cellType: CharacterGalleryTableViewCell.self)
    }
    
    func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Characters"
        searchController.searchBar.scopeButtonTitles = presenter.scopeTitles
        
        definesPresentationContext = true
        
        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
    }
    
}

extension CharacterGalleryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: CharacterGalleryTableViewCell.self, for: indexPath)
        
        guard let information = presenter.object(at: indexPath) else { return cell }
        
        cell.characterLabel?.text = information.name
        
        cell.backgroundImageView.layer.cornerRadius = 15.0
        cell.backgroundImageView.kf.setImage(with: information.imageURL, placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(.fade(0.2))])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(presenter.heightForRow(at: indexPath))
    }
    
}

extension CharacterGalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension CharacterGalleryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let scopeIndex = searchController.searchBar.selectedScopeButtonIndex
        presenter.search(for: searchController.searchBar.text, withScope: scopeIndex)
    }
}

extension CharacterGalleryViewController: StoryboardInstantiatable {
    static var storyboardName: String {
        return "Main"
    }
}



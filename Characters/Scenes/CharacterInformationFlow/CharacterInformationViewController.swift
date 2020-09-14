//
//  CharacterInformationViewController.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterInformationViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileBackgroundView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: CharacterInformationViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpProfileData()
        
        presenter.viewDidLoad()
        title = presenter.characterName
        
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.register(cellType: CharacterInformationTableViewCell.self)
    }
    
    func setUpProfileData() {
        profileImageView.layer.cornerRadius = 70
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.backgroundColor = UIColor.black.cgColor
        profileImageView.kf.setImage(with: presenter.profileImageURL, placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(.fade(0.2))], completionHandler: { result in
            switch result {
                case .success(let imgResult):
                    DispatchQueue.main.async {
                        self.profileBackgroundView.backgroundColor = imgResult.image.averageColor
                }
                case .failure(_): break
            }
        })
    }
    
}

extension CharacterInformationViewController: UITableViewDataSource {
    
    // MARK: - TableView DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: CharacterInformationTableViewCell.self, for: indexPath)
        
        guard let item = presenter.object(at: indexPath) else { return cell }
        
        cell.textLabel?.text = item.feild
        cell.detailTextLabel?.text = item.value
        
        return cell
    }
}

extension CharacterInformationViewController: CharacterInformationView {
    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension CharacterInformationViewController: StoryboardInstantiatable {
    static var storyboardName: String {
        return "Main"
    }
}

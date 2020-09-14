//
//  CharacterFlowCoordinator.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterGallerySceneDelegate: class {
    func didSelect(_ characterInformation: CharacterInformation)
}

class CharacterFlowCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    
    private let navigationController: UINavigationController
    private let client: APIClient
    
    init(_ navigationController: UINavigationController, childCoordinators: [Coordinator] = [], client: APIClient) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
        self.client = client
    }
    
    func start() {
        
        // Create the M.V.P stack
        let characterGalleryView = CharacterGalleryViewController.instantiate()
        let presenter = CharacterGalleryPresenter(view: characterGalleryView, items: [], client: client)
        presenter.delegate = self
        characterGalleryView.presenter = presenter
        
        // Setup the stack as the root 
        navigationController.setViewControllers([characterGalleryView], animated: true)
    }
    
    
}

extension CharacterFlowCoordinator: CharacterGallerySceneDelegate {
    
    func didSelect(_ characterInformation: CharacterInformation) {
        
        let characterInformationView = CharacterInformationViewController.instantiate()
        let presenter = CharacterInformationPresenter(view: characterInformationView, item: characterInformation)
        characterInformationView.presenter = presenter
        
        navigationController.pushViewController(characterInformationView, animated: true)
    }
}

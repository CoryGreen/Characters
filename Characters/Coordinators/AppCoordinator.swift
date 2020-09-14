//
//  AppCoordinator.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator : Coordinator {
    
    let window : UIWindow
    let client: APIClient
    var childCoordinators : [Coordinator]
    
    init(window: UIWindow, childCoordinators: [Coordinator] = []) {
        self.window = window
        self.client = CharacterClient()
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let characterFlowCoordinator = CharacterFlowCoordinator(navigationController, client: client)
        
        // store child coordinator
        self.store(characterFlowCoordinator)
        characterFlowCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}

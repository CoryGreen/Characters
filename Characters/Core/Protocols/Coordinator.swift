//
//  Coordinator.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    func start()
}

extension Coordinator {
    
    func store(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
    }
    
    func free(_ coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

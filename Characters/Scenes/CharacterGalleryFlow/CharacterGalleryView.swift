//
//  CharacterGalleryView.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

protocol CharacterGalleryView: class {
    
    func updateTable()
    func showLoaderSpinner()
    func hideLoaderSpinner()
}

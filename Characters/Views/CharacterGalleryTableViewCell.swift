//
//  CharacterGalleryTableViewCell.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import UIKit

class CharacterGalleryTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var characterLabel: UILabel!
    
    override func prepareForReuse() {
        backgroundImageView?.image = #imageLiteral(resourceName: "placeholder")
        characterLabel?.text = nil
    }
}

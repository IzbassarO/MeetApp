//
//  CategoryCollectionViewCell.swift
//  MeetApp
//
//  Created by Izbassar on 20.12.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func generateCell(_ category: Category) {
        
        nameLabel.text = category.name
        imageView.image = category.image
    }
}

//
//  ItemTableViewCell.swift
//  MeetApp
//
//  Created by Izbassar on 20.12.2023.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func generateCell(_ item: Item) {
        
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.price!)"
        
        //TODO: Download image
        if item.imageLinks != nil && item.imageLinks.count > 0 {
            
            downloadImages(imageUrls: [item.imageLinks.first!]) { (images) in
                self.itemImageView.image = images.first as? UIImage
            }
        }
    }
}

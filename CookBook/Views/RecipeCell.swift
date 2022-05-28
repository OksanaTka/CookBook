//
//  RecipeCell.swift
//  CookBook
//
//  Created by user216397 on 5/28/22.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipe_LBL_likes: UILabel!
    @IBOutlet weak var recipe_IMG_like: UIImageView!
    @IBOutlet weak var recipe_LBL_name: UILabel!
    @IBOutlet weak var recipe_IMG_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

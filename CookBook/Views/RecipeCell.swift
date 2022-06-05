//
//  RecipeCell.swift
//  CookBook
//
//  Created by user216397 on 5/28/22.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject{
    func didTapButton(index: Int)
}

class RecipeCell: UITableViewCell {
    
    weak var delegate: MyTableViewCellDelegate?

    @IBOutlet weak var recipe_LBL_likes: UILabel!
    @IBOutlet weak var recipe_LBL_name: UILabel!
    @IBOutlet weak var recipe_IMG_image: UIImageView!
    @IBOutlet weak var recipe_IMG_like: UIImageView!
    @IBOutlet weak var recipe_BTN_detailes: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipe_IMG_image.layer.cornerRadius = recipe_IMG_image.frame.size.height / 5
        
    }
    
    @IBAction func showRecipeDetails(_ sender: UIButton) {
        let indexBTN = sender.tag
        delegate?.didTapButton(index: indexBTN)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}

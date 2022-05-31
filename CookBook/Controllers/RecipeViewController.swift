//
//  RecipeViewController.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var recipe: Recipe?
    var recipeData = RecipeData.recipeData
    var recipeIndex: Int?
    var recipeDetailsBrain = RecipeDetailsBrain()

    @IBOutlet weak var details_IMG_image: UIImageView!
    @IBOutlet weak var details_LBL_instructions: UILabel!
    @IBOutlet weak var details_LBL_ingrediencies: UILabel!
    @IBOutlet weak var details_LBL_description: UILabel!
    
    @IBOutlet weak var details_LBL_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let index = Array(recipeData.getRecipeMap().keys)[recipeIndex ?? 0]
        recipe = recipeData.getRecipeMap()[index]!
        
        
        initView()

    }
    
    func initView(){
        details_IMG_image.imageFrom(url: (recipe?.imageURL)!)
        details_LBL_name.text = recipe?.name!
        details_LBL_instructions.text = recipe?.instructions
        details_LBL_ingrediencies.text = recipe?.ingrediencies
        details_LBL_description.text = recipe?.description
        
    }

    @IBAction func NavigateBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

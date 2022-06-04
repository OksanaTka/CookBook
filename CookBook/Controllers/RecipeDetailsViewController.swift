//
//  RecipeViewController.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

protocol TableViewCellDelegate: AnyObject{
    func updateTable()
}

class RecipeDetailsViewController: UIViewController {
    
    weak var delegate: TableViewCellDelegate?
    
    var recipe: Recipe?
    var recipeData = RecipeData.recipeData
    var index: Int?
    var recipeIndex: String?
    var recipeDetailsBrain = RecipeDetailsBrain()
    var recipeDate = RecipeData.recipeData
    let user = User.user
    let db = Firestore.firestore()

    @IBOutlet weak var details_BTN_like: UIButton!
    @IBOutlet weak var details_IMG_image: UIImageView!
    @IBOutlet weak var details_LBL_instructions: UILabel!
    @IBOutlet weak var details_LBL_ingrediencies: UILabel!
    @IBOutlet weak var details_LBL_description: UILabel!
    
    @IBOutlet weak var details_LBL_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeIndex = Array(recipeData.getRecipeMap().keys)[index ?? 0]
        
        recipe = recipeData.getRecipeMap()[recipeIndex!]!
       
        setLike()
        
        initView()

    }
    
    func setLike(){
        
    }
    
    @IBAction func LikeOnClick(_ sender: UIButton) {
        if user.getLikedRecipeList().contains(recipeIndex!) {
            details_BTN_like.setImage(UIImage(named: "Unlike"), for: .normal)
            user.removeLikedRecipe(recipeId: recipeIndex!)
           
        }else{
            details_BTN_like.setImage(UIImage(named: "Like"), for: .normal)
            user.addLikedRecipe(recipeId: recipeIndex!)
        }
        
        updateLikeRecipe()
    }
    
    func updateLikeRecipe(){
            let washingtonRef = db.collection("users").document(user.getUserPhone())
            
            
            // Set the "capital" field of the city 'DC'
            washingtonRef.updateData([
                "likes": user.getLikedRecipeList()
            ]) { err in
                if let err = err {
                    // self.addNewUser()
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
        
    }
    
    func initView(){
        details_IMG_image.imageFrom(url: (recipe?.imageURL)!)
        details_LBL_name.text = recipe?.name!
        details_LBL_instructions.text = recipe?.instructions
        details_LBL_ingrediencies.text = recipe?.ingrediencies
        details_LBL_description.text = recipe?.description
        
    }

    @IBAction func NavigateBack(_ sender: UIButton) {
        delegate?.updateTable()

        self.dismiss(animated: true, completion: nil)
    }
    
}

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
    
    
    var index: Int?
    var recipeIndex: String?
    var recipeDetailsBrain = RecipeDetailsBrain()
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var details_BTN_like: UIButton!
    @IBOutlet weak var details_IMG_image: UIImageView!
    @IBOutlet weak var details_LBL_instructions: UILabel!
    @IBOutlet weak var details_LBL_ingrediencies: UILabel!
    @IBOutlet weak var details_LBL_description: UILabel!
    
    @IBOutlet weak var details_LBL_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        details_IMG_image.layer.cornerRadius = details_IMG_image.frame.size.height / 5

        recipeDetailsBrain.setCurrentRecipeIndex(cellIndex: index!)
        
        setLike()
        initView()
        
    }
    
    func setLike(){
        if(!recipeDetailsBrain.likesListIsEmpty() && recipeDetailsBrain.indexExistInLikesList()){
            details_BTN_like.setImage(UIImage(named: "Like"), for: .normal)
        }
        else{
            details_BTN_like.setImage(UIImage(named: "Unlike"), for: .normal)
        }
    }
    
    @IBAction func LikeOnClick(_ sender: UIButton) {
        if recipeDetailsBrain.indexExistInRecipesList() {
            details_BTN_like.setImage(UIImage(named: "Unlike"), for: .normal)
            recipeDetailsBrain.removeUnlikedRecipeFromList()
            recipeDetailsBrain.decreaseLikeFromRecipe()
            
        }else{
            details_BTN_like.setImage(UIImage(named: "Like"), for: .normal)
            recipeDetailsBrain.addLikedRecipeToList()
            recipeDetailsBrain.addLikeToRecipe()
        }
        
        UpdateLikeRecipe()
        updateLikeNumberRecipe()
    }
    
    func updateLikeNumberRecipe(){
        let  numberOfLikes =  recipeDetailsBrain.getNumberOfLikes()
        db.collection("recipes").document(recipeDetailsBrain.getCurrentRecipeIndex()).updateData([
            "numberOfLikes": numberOfLikes,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func UpdateLikeRecipe(){
        let washingtonRef = db.collection("users").document(recipeDetailsBrain.getUserPhone())
        
        washingtonRef.updateData([
            "likes": recipeDetailsBrain.getUserLikedList()
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func initView(){
        let recipe = recipeDetailsBrain.getRecipe()!
        details_IMG_image.imageFrom(url: (recipe.imageURL)!)
        details_LBL_name.text = recipe.name!
        details_LBL_instructions.text = recipe.instructions
        details_LBL_ingrediencies.text = recipe.ingrediencies
        details_LBL_description.text = recipe.description
        
    }
    
    @IBAction func NavigateBack(_ sender: UIButton) {
        delegate?.updateTable()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

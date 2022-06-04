//
//  RecipeDetailsBrain.swift
//  CookBook
//
//  Created by user216397 on 5/31/22.
//

import Foundation
import Foundation
struct RecipeDetailsBrain {

    var currentRecipeIndex: String?
    var recipe: Recipe?
    var recipeData = RecipeData.recipeData
    var user = User.user
    
    mutating func setCurrentRecipeIndex(cellIndex: Int){
        currentRecipeIndex = Array(recipeData.getRecipeMap().keys)[cellIndex]
        setRecipe()
    }
    
    func getCurrentRecipeIndex() -> String{
        return currentRecipeIndex!
    }
    
    mutating func setRecipe(){
        self.recipe = recipeData.getRecipeMap()[currentRecipeIndex!]
    }
    
    func decreaseLikeFromRecipe(){
        recipeData.decreaseLikeFromRecipe(currentRecipeIndex!)
    }
    func addLikeToRecipe(){
        recipeData.addLikeToRecipe(currentRecipeIndex!)
    }
    
    func getNumberOfLikes() -> Int{
        return (recipeData.getRecipeMap()[currentRecipeIndex!]?.numberOfLikes)!
    }
    
    
    func getRecipe() -> Recipe!{
        return recipe
    }
    
    func  indexExistInLikesList() -> Bool{
        return user.getLikedRecipeList().contains(currentRecipeIndex!) ? true : false
    }
    
    func  indexExistInRecipesList() -> Bool{
        return user.getLikedRecipeList().contains(currentRecipeIndex!) ? true : false
    }
    
    func likesListIsEmpty() -> Bool{
        return user.getLikedRecipeList().isEmpty
    }
    
    func removeUnlikedRecipeFromList(){
        user.removeLikedRecipe(recipeId: currentRecipeIndex!)
    }
    func addLikedRecipeToList(){
        user.addLikedRecipe(recipeId: currentRecipeIndex!)
    }
    
    func getUserPhone() -> String{
        return user.getUserPhone()
    }
    func getUserLikedList() -> [String]{
        return user.getLikedRecipeList()
    }
    
}


//
//  HomeBrain.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import Foundation
struct HomeBrain {
    var userRecipe = Recipe()
    var recipeData = RecipeData.recipeData
    
    
   mutating func setUserRecipeName(name: String){
        self.userRecipe.name = name
    }
    mutating func setUserRecipeLike(like: Bool){
        self.userRecipe.like = like
    }
    mutating func setUserRecipeImage(image: String){
        self.userRecipe.imageName = image
    }
    
    mutating func addRecipeToMap(recipeId: String,newRecipe: Recipe){
        self.recipeData.addRecipeToMap(recipeId, newRecipe)
        
    }
    
    func getRecipeMap() -> [String:Recipe]{
        return recipeData.getRecipeMap()
    }
    
    func getRecipeMapSize() -> Int{
        return recipeData.getRecipeMap().count
    }
    
    
}

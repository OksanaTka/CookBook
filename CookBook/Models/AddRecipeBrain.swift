//
//  AddRecipeBrain.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import Foundation
struct AddRecipeBrain {
    var newRecipe = Recipe()
    
    
   mutating func setUserRecipeName(name: String){
        self.newRecipe.name = name
    }
    mutating func setUserRecipeLike(like: Bool){
        self.newRecipe.like = like
    }
    mutating func setUserRecipeImage(image: URL){
        self.newRecipe.image = image
    }
    
    mutating func setUserRecipeInstructions(instructions: String){
        self.newRecipe.instructions = instructions
    }
    
    mutating func setUserRecipeIngrediencies(ingrediencies: String){
        self.newRecipe.ingrediencies = ingrediencies
    }
    
    mutating func setUserRecipeDescription(description: String){
        self.newRecipe.description = description
    }
    
    mutating func setUserRecipeUserId(userId: String){
        self.newRecipe.userId = userId
    }
    
    func getRecipe() -> Recipe{
        return newRecipe
    }
    

}

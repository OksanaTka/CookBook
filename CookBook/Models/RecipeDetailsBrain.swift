//
//  RecipeDetailsBrain.swift
//  CookBook
//
//  Created by user216397 on 5/31/22.
//

import Foundation
//
//  HomeBrain.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import Foundation
struct RecipeDetailsBrain {

    var currentRecipeIndex: Int?
    var recipe: Recipe?
    
    
    mutating func setCurrentRecipeIndex(index: Int){
        self.currentRecipeIndex = index
    }
    
    func getCurrentRecipeIndex() -> Int?{
        return currentRecipeIndex
    }
    
    mutating func setRecipe(recipe: Recipe){
        self.recipe = recipe
    }
    
    func getRecipe() -> Recipe!{
        return recipe
    }
    
    
}


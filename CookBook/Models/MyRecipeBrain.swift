//
//  MyRecipeBrain.swift
//  CookBook
//
//  Created by Oksana Tkachenko on 05/06/2022.
//

import Foundation

struct MyRecipeBrain {
    
    let recipeData = RecipeData.recipeData
    let user = User.user
    
    
    func initUserRecipeMap() -> Bool{
        var recipeExist = false
        if(!user.getRecipeList().isEmpty){
            for recipeId in user.getRecipeList() {
                if(!recipeData.getRecipeMap().isEmpty){
                    if let recipe = recipeData.getRecipeMap()[recipeId] {
                        recipeData.addUserRecipeToMap(recipeId, recipe)
                        recipeExist = true
                    }
                }
            }
        }
        return recipeExist
    }
    
    func getUserRecipeMapSize() -> Int{
        return recipeData.getUserRecipeMap().count
    }
    
    func getUserRecipeMap() -> [String:Recipe]{
        return recipeData.getUserRecipeMap()
    }
    
    
    
}

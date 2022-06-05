//
//  RecipeData.swift
//  CookBook
//
//  Created by user216397 on 5/28/22.
//

import Foundation
class RecipeData {
    static let recipeData = RecipeData()
    private var recipesMap: [String:Recipe] = [:]
    private var userRecipesMap: [String:Recipe] = [:]
    
    var initRecipe: Bool?
    //Initializer access level change now
    private init(){}
    
    func addRecipeToMap(_ recipeId: String,_ newRecipe: Recipe){
        recipesMap[recipeId] = newRecipe
    }
    
    
    func getRecipeMap() -> [String:Recipe]{
        return recipesMap
    }
    
    func addLikeToRecipe(_ recipeId: String){
        let currentValue = (recipesMap[recipeId]?.numberOfLikes)!
        recipesMap[recipeId]?.numberOfLikes = currentValue + 1
    }
    func decreaseLikeFromRecipe(_ recipeId: String){
        let currentValue = (recipesMap[recipeId]?.numberOfLikes)!
        recipesMap[recipeId]?.numberOfLikes = currentValue - 1
    }
    
    func addUserRecipeToMap(_ recipeId: String,_ newRecipe: Recipe){
        userRecipesMap[recipeId] = newRecipe
    }
    
    func getUserRecipeMap() -> [String:Recipe]{
        return userRecipesMap
    }
}

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
    
    
    var initRecipe: Bool?
    //Initializer access level change now
    private init(){}
    
    func addRecipeToMap(_ recipeId: String,_ newRecipe: Recipe){
        recipesMap[recipeId] = newRecipe
    }
    
    
    func getRecipeMap() -> [String:Recipe]{
        return recipesMap
    }
}

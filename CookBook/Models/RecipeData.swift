//
//  RecipeData.swift
//  CookBook
//
//  Created by user216397 on 5/28/22.
//

import Foundation
class RecipeData {
    static let recipeData = RecipeData()
    private var recipesList: [Recipe] = []
    
    
    var initRecipe: Bool?
    //Initializer access level change now
    private init(){}
    
    func addRecipeToList(newRecipe: Recipe){
        recipesList.append(newRecipe)
    }
    
    func getRecipeList() -> [Recipe]{
        return recipesList
    }
}

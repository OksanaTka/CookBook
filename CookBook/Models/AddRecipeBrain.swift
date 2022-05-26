//
//  AddRecipeBrain.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import Foundation
struct AddRecipeBrain {
    var userRecipe = Recipe()
    
    
   mutating func setUserRecipeName(name: String){
        self.userRecipe.name = name
    }
    mutating func setUserRecipeLike(like: Bool){
        self.userRecipe.like = like
    }
    mutating func setUserRecipeImage(image: URL){
        self.userRecipe.image = image
    }
}

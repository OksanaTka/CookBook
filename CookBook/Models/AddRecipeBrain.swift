//
//  AddRecipeBrain.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import Foundation
struct AddRecipeBrain {
    var newRecipe = Recipe()
    var ImagePathUserPhone: URL?
    var user = User.user
    
    func getImageName() -> String{
        return "\(user.getUserPhone())/\(newRecipe.name).jpg"
    }
    
    mutating func setImagePathUserPhone(path: URL){
         self.ImagePathUserPhone = path
     }
    
     func getImagePathUserPhone() -> URL{
         return ImagePathUserPhone!
     }
    
    mutating func setImageURL(imageURL: URL) {
        return newRecipe.imageURL = imageURL
    }
    
    func getImageURL() -> URL{
        return newRecipe.imageURL!
    }
    
   mutating func setUserRecipeName(name: String){
        self.newRecipe.name = name
    }
    
    mutating func setNumberOfLikes(likesNumber: Int){
         self.newRecipe.numberOfLikes = likesNumber
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

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
    let recipeData = RecipeData.recipeData
    
    func getImageName() -> String{
        return "\(user.getUserPhone())/\(newRecipe.name!).jpg"
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
    
    mutating func setUserRecipeIngredients(ingredients: String){
        self.newRecipe.ingredients = ingredients
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
    
    func addNewRecipeIdUserList(recipeId: String){
        user.addRecipeIdToList(recipeId: recipeId)
    }
    
    func addNewRecipeToMap(recipeId: String, recipe: Recipe){
        recipeData.addRecipeToMap(recipeId, recipe)
    }
    
    func getUserRecipeIdList() -> [String]{
        return user.getRecipeList()
    }
    
    func getUserPhone() -> String{
        return user.getUserPhone()
    }
    
    func getUser() -> User{
        return user
    }
    
    func addUserRecipeToMap(recipeId: String , recipe:Recipe){
        recipeData.addUserRecipeToMap(recipeId, recipe)
    }
    

}

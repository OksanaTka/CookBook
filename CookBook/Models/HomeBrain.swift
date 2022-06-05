
import Foundation
struct HomeBrain {
    
    var userRecipe = Recipe()
    let recipeData = RecipeData.recipeData
    let user = User.user
    
    var currentRecipeIndex: Int?
    
    
    mutating func setCurrentRecipeIndex(index: Int){
        self.currentRecipeIndex = index
    }
    
    func getCurrentRecipeIndex() -> Int?{
        return currentRecipeIndex
    }
    
   mutating func setUserRecipeName(name: String){
        self.userRecipe.name = name
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
    
    func recipeExistInLikedList(recipeId: String) ->Bool {
         return !user.getLikedRecipeList().isEmpty && user.getLikedRecipeList().contains(recipeId)
    }
    
    
}

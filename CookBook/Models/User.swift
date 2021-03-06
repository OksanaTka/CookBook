//
//  User.swift
//  CookBook
//
//  Created by user216397 on 5/27/22.
//

import Foundation
class User{
    
    static let user = User()
    private var userPhone: String?
    private var userRecipesIdList: [String] = []
    private var userLikedRecipesIdList: [String] = []
    
    var initUser: Bool?
    
    private init(){}
    
    
    func addRecipeIdToList(recipeId: String){
        userRecipesIdList.append(recipeId)
    }
    
    func getRecipeList() -> [String]{
        return userRecipesIdList
    }
    
    func setRecipeList(recipeIdsList: [String]){
        self.userRecipesIdList.append(contentsOf: recipeIdsList)
    }
    func getUserPhone() -> String{
        return userPhone!
    }
    func setUserPhone(userPhone: String){
        self.userPhone = userPhone
    }
    
    func addLikedRecipe(recipeId: String){
       userLikedRecipesIdList.append(recipeId)
    }
    
    func removeLikedRecipe(recipeId: String){
       userLikedRecipesIdList.removeAll {$0 == recipeId}
    }
    
    func getLikedRecipeList() -> [String]{
        return userLikedRecipesIdList
    }
    
    func setLikedRecipeList(recipeLikedIdsList: [String]){
        self.userLikedRecipesIdList.append(contentsOf: recipeLikedIdsList)
    }
    
}

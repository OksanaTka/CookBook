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
    
    
    var initUser: Bool?
    //Initializer access level change now
    private init(){}
    
    func getUser(){
        //Code Process
        initUser = true
        print("Location granted")
    }
    
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
    
}

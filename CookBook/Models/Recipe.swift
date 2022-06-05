//
//  Recipe.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import Foundation
struct Recipe : Codable{
    var userId: String?
    var name: String?
    var numberOfLikes: Int?
    var instructions: String?
    var ingredients: String?
    var description: String?
    var imageURL: URL?
}

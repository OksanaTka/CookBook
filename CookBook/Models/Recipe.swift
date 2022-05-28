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
    var like: Bool?
    var numberOfLikes: Int?
    var imageName: String?
    var instructions: String?
    var ingrediencies: String?
    var description: String?
    var imageURL: URL?
}

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
    var image: URL?
    var instructions: String?
    var ingrediencies: String?
    var description: String?
}

//
//  RandomRecipe.swift
//  RecipeApp
//
//  Created by Fernando Zelaya on 5/13/20.
//  Copyright © 2020 Fernando Zelaya. All rights reserved.
//

import Foundation


struct RandomRecipe: Codable {
    let recipes: [Recipe]
}


struct Recipe: Codable {
    let title: String
    let image: String
    let readyInMinutes, servings: Int
}

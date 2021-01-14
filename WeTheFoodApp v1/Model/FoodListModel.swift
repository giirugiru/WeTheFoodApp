//
//  FoodListModel.swift
//  WeTheFood App
//
//  Created by Gilang Sinawang on 14/01/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FoodListWelcome: Codable {
    let meals: [FoodListMeal]
}

// MARK: - Meal
struct FoodListMeal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

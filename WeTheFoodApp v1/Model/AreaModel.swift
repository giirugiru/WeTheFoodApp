//
//  CategoryModel.swift
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
struct AreaWelcome: Codable {
    let meals: [AreaMeal]
}

// MARK: - Meal
struct AreaMeal: Codable {
    let strArea: String
}

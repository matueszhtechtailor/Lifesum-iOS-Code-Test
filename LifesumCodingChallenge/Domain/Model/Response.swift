// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let response = try? newJSONDecoder().decode(Response.self, from: jsonData)

import Foundation

// MARK: - Response
public struct Response: Codable {
    let carbs: Double?
    let fiber: Double?
    let title, pcstext: String?
    let potassium, sodium: Double?
    let calories: Double?
    let fat, sugar: Double?
    let gramsperserving: Double?
    let cholesterol, protein, unsaturatedfat, saturatedfat: Double?
}

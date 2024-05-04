//
//  Listing.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//

import Foundation


// MARK: - ListingModelElement
struct ListingModel: Codable {
    let alphaTwoCode: String?
    let name: String?
    let country: String?
    let domains: [String]?
    let webPages: [String]?
    let stateProvince: String?

    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case name, country, domains
        case webPages = "web_pages"
        case stateProvince = "state-province"
    }
}

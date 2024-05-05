//
//  RealmTestModel.swift
//  InvadeMSTaskTests
//
//  Created by Ahmad on 05/05/2024.
//

import Foundation
import RealmSwift


class RealmListTest: Object {
    var list =  List<RealmListingModelTest>()
}

class RealmListingModelTest: Object {
    @objc dynamic var alphaTwoCode: String?
    @objc dynamic var name: String?
    @objc dynamic var country: String?
    var domains = List<String>()
    var webPages = List<String>()
    @objc dynamic var stateProvince: String?

    convenience init(listingModel: ListingModel) {
        self.init()
        self.alphaTwoCode = listingModel.alphaTwoCode
        self.name = listingModel.name
        self.country = listingModel.country
        self.domains.append(objectsIn: listingModel.domains ?? [])
        self.webPages.append(objectsIn: listingModel.webPages ?? [])
        self.stateProvince = listingModel.stateProvince
    }
}

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


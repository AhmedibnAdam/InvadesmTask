//
//  ListingRealmModel.swift
//  InvadeMSTask
//
//  Created by Ahmad on 04/05/2024.
//

import Foundation
import RealmSwift

class RealmList: Object {
    var list =  List<RealmListingModel>()
}

class RealmListingModel: Object {
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

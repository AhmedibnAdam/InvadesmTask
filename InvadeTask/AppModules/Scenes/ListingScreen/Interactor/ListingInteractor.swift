//
//  ListingInteractor.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//

import Foundation
import RealmSwift


class ListingInteractor: ListingInteractorInputProtocol {
    
    //MARK: - variable
    weak var presenter: ListingInteractorOutputProtocol?
    
    //MARK: - fetch listing

    func fetchListing() {
        let parameters: [String: String] = ["": ""]
        NetworkLayer.instance.fetchData(method: .get, url: Constants.listingEndpoint, parameters: parameters, headers: [:]) { [weak self] (result: Result<[ListingModel]>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                cashData(model)
                self.presenter?.onSuccess(listing: model)
            case .failure(let error):
                self.presenter?.onFail(withError: error)
            }
        }
    }
    
    private func cashData(_ model: [ListingModel]) {
        let realmObject = RealmList()
        for item in model {
            let realmList = RealmListingModel()
            realmList.alphaTwoCode = item.alphaTwoCode!
            realmList.name =  item.name!
            realmList.country = item.country!
            realmObject.list.append(realmList)
        }
        
        RealmManager.shared.addObject(realmObject: realmObject , andCompletion : {
            (addResult) in
            print(addResult)
        } )
    }
    
}

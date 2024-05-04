//
//  DetailsScreenProtocol.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//

import Foundation
import UIKit
protocol DetailsScreenProtocol: AnyObject {
    var presenter: DetailsScreenPresenterProtocol! { get set }
    func update(with model: ListingModel)
}

protocol DetailsScreenPresenterProtocol: AnyObject {
    var view: DetailsScreenProtocol? { get set }
    func viewDidLoad(model: ListingModel)
}
protocol DetailsScreenRouterProtocol {
}

protocol DetailsScreenInteractorInputProtocol {
    var presenter: DetailsScreenInteractorOutputProtocol? { get set }
}

protocol DetailsScreenInteractorOutputProtocol: AnyObject {

}


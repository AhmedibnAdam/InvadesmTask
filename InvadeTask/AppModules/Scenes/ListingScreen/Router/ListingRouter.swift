//
//  ListingRouter.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//

import UIKit

class ListingRouter: ListingRouterProtocol, DetailsScreenRouterProtocol {
    
    // MARK: - Variables
    
    // Weak reference to the view controller to avoid retain cycles
    weak var viewController: UIViewController?
    
    // MARK: - Listing Module Setup
    
    static func listingModule() -> UIViewController {
        let view = ListingViewController()
        let interactor = ListingInteractor()
        let router = ListingRouter()
        let presenter = ListingPresenter(view: view, interactor: interactor, router: router)
        
        // Connect components
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Details Module Setup
    
    static func detailsteModule(model: ListingModel) -> UIViewController {
        let view = DetailsScreenViewController()
        let interactor = DetailsInteractor()
        let router = ListingRouter()
        let presenter = DetailsScreenPresenter(view: view, interactor: interactor, router: router)
        
        // Connect components
        view.presenter = presenter
        view.listingModel = model
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

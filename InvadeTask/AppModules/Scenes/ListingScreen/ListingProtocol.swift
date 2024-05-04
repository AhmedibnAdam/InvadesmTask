//
//  ListingProtocol.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//

import Foundation
import UIKit
protocol ListingViewProtocol: AnyObject {
    var presenter: ListingPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    func listingTableView() -> UITableView
}

protocol ListingPresenterProtocol: AnyObject {
    var view: ListingViewProtocol? { get set }
    var numberOfRows: Int { get }
    func viewDidLoad()
    func configure(cell: ListingCellView, indexPath: IndexPath)
    func listing(for row: Int) -> ListingModel
}

protocol ListingRouterProtocol {
}

protocol ListingInteractorInputProtocol {
    var presenter: ListingInteractorOutputProtocol? { get set }
    func fetchListing()
}

protocol ListingInteractorOutputProtocol: AnyObject {
    func onSuccess(listing: [ListingModel])
    func onFail(withError error: Error)
}

protocol ListingCellView {
    func configure(viewModel: ListingModel)
}

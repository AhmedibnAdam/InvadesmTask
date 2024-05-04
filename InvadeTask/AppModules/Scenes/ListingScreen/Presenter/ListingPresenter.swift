//
//  ListingPresenter.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//
import Foundation
import UIKit
class ListingPresenter: ListingPresenterProtocol, ListingInteractorOutputProtocol {
    
    //MARK: - variable
    weak var view: ListingViewProtocol?
    private let interactor: ListingInteractorInputProtocol
    private let router: ListingRouterProtocol
    private var listing = [ListingModel]()
    private let refreshControl =  UIRefreshControl()
    
    var numberOfRows: Int {
        return listing.count
    }
    
    init(view: ListingViewProtocol, interactor: ListingInteractorInputProtocol, router: ListingRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoadingIndicator()
        interactor.fetchListing()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view?.listingTableView().refreshControl = refreshControl
    }
    
    func onSuccess(listing: [ListingModel]) {
        view?.hideLoadingIndicator()
        self.listing.append(contentsOf: listing)
        view?.reloadData()
    }
    
    func onFail(withError error: Error) {
        view?.hideLoadingIndicator()
    }
    
    func configure(cell: ListingCellView, indexPath: IndexPath) {
        let listing = listing[indexPath.row]
        cell.configure(viewModel: listing)
    }
    
    func listing(for row: Int) -> ListingModel {
        let listing = self.listing[row]
        return listing
    }
    //MARK: - refresh view
    @objc func refresh() {
        refreshControl.endRefreshing()
        viewDidLoad()
        
    }
}

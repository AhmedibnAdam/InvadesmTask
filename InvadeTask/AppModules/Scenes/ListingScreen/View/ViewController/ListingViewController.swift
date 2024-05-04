//
//  ListingViewController.swift
//  InvadeTask
//
//  Created by Ahmad on 04/05/2024.
//

import UIKit
import MBProgressHUD

class ListingViewController: UIViewController, ListingViewProtocol {
  
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var presenter: ListingPresenterProtocol!
   
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Notify presenter that the view will appear
        presenter.viewDidLoad()
    }
    
    private func setupUI(){
        navigationItem.title = "Listing Screen"
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.register(ListingCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Show Loading Indicator
    func showLoadingIndicator() {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = ""
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    
    // MARK: - Hide Loading Indicator
    func hideLoadingIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    
    // MARK: - Reload Data
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - Get TableView Instance
    func listingTableView() -> UITableView {
        return self.tableView
    }

    // MARK: - Navigate To Listing Details
    func navigateToListingDetails(model: ListingModel) {
        navigationController?.pushViewController(ListingRouter.detailsteModule(model: model), animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ListingCell.self, for: indexPath)
        // Configure the cell using presenter
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle selection and navigate to details
        navigateToListingDetails(model: presenter.listing(for: indexPath.row))
    }
}

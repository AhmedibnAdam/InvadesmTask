//
//  DetailsScreenViewController.swift
//  InvadeTask
//
//  Created by Ahmad on 04/05/2024.
//

import UIKit

class DetailsScreenViewController: UIViewController, DetailsScreenProtocol {
   
    // MARK: - Outlets
    
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityStateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var webPageButton: UIButton!
    
    // MARK: - Variables
    
    var presenter: DetailsScreenPresenterProtocol!
    var listingModel: ListingModel!
    var webPage: String = ""
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad(model: listingModel)
    }
    
    // MARK: - Update View with Model
    private func setupUI(){
        navigationItem.title = "Details Screen"
    }
    
    func update(with model: ListingModel) {
        universityNameLabel.text = model.name ?? ""
        universityStateLabel.text = model.stateProvince ?? ""
        countryLabel.text = model.country ?? ""
        countryCodeLabel.text = model.alphaTwoCode ?? ""
        webPageButton.setTitle(model.webPages?.first ?? "", for: .normal)
        webPage = model.webPages?.first ?? ""
    }
    
    // MARK: - Button Action
    
    @IBAction func webPageAction(_ sender: Any) {
        guard let url = URL(string: webPage) else { return }
        UIApplication.shared.open(url)
    }
}

//
//  ListingCell.swift
//  InvademsTask
//
//  Created by Ahmad on 03/05/2024.
//

import UIKit

class ListingCell: UITableViewCell, ListingCellView {

    //MARK: - out let
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var universityState: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: - configure cell
    func configure(viewModel: ListingModel) {
        universityName.text = viewModel.name ?? ""
        universityState.text = viewModel.country ?? ""
    }
    
}

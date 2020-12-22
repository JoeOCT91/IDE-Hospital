//
//  SearchResultCell.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/22/20.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var searchResultCellView: SearchResultCellView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.searchResultCellView.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

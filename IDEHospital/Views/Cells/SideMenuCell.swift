//
//  SideMenuCell.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 28/12/2020.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    private let itemTitle = UILabel(frame: .zero)
    private let itemImageIcon = UIImageView(frame: .zero)
    private let arrowImageView = UIImageView(image: Asset.sideMenuBack.image)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    override func layoutSubviews() {
        self.selectedBackgroundView?.frame = CGRect.zero
    }
    func setupCell(item: SideMenuItem){
        itemTitle.text = item.title
        itemImageIcon.image = UIImage(named: item.image)
    }
    private func configureCell(){
        contentView.addSubview(itemTitle)
        contentView.addSubview(itemImageIcon)
        contentView.addSubview(arrowImageView)
    }
    


    

}

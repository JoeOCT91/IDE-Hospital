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
    
    //MARK:- Public Methods
    func setupCell(item: SideMenuItem){
        configureCell()
        itemTitle.text = item.title
        itemImageIcon.image = UIImage(named: item.image)
    }
    
    //MARK:- Private Methods
    private func configureCell(){
        contentView.addSubview(itemTitle)
        contentView.addSubview(itemImageIcon)
        contentView.addSubview(arrowImageView)
        configureCellViews()
    }
    private func configureCellViews(){
        contentView.backgroundColor = .clear
        itemImageIcon.contentMode = .scaleToFill
        itemTitle.font = UIFont(name: FontFamily.PTSans.regular.name, size: 20)
        itemTitle.font = itemTitle.font.withSize(20)
        itemTitle.textColor = UIColor(named: ColorName.darkRoyalBlue)
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        itemImageIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            itemImageIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: itemImageIcon.trailingAnchor, constant: 15),
            itemTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

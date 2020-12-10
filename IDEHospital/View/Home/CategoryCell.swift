//
//  CategoryCollectionViewCell.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 10/12/2020.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let reuseID  = "CategoryCell"
    private let container = UIView()
    private let categoryLogoImage = UIImageView(frame: .zero)
    private let categoryTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(){
        contentView.addSubview(container)
        contentView.addSubview(categoryLogoImage)
        contentView.addSubview(categoryTitle)
        
        categoryTitle.textColor = .white
        categoryTitle.textAlignment = .center
        categoryTitle.font = UIFont(font: FontFamily.PTSans.bold, size: 15)
        categoryTitle.font = categoryTitle.font.withSize(15)

        
        container.translatesAutoresizingMaskIntoConstraints = false
        categoryLogoImage.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        
        container.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            categoryTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    func setupCell(color: String, categoryTitle: String){
        
        self.container.backgroundColor = UIColor(hexString: color)
        self.categoryTitle.text = categoryTitle
    }
}

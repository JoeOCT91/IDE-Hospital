//
//  HomeView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import UIKit

class HomeView: UIView {
    
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var categoriesButtons: [UIButton]!
    @IBOutlet weak var logoImage: UIImageView!
    
    private var index = 0
    
    func setup() {
        configureBackground()
        configureDescriptionLabel()
        configureLogo()
        
    }
    
    private func configureBackground() {
        backgroundImage.image = UIImage(named: "splashBackGround")
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.frame = UIScreen.main.bounds
    }
    
    private func configureLogo(){
        logoImage.image = Asset.logo.image
        logoImage.contentMode = .scaleToFill
    }
    
    func configureButton(category: Category){
        categoriesButtons[index].layer.cornerRadius = 12
        categoriesButtons[index].tag = category.id
        categoriesButtons[index].backgroundColor =  UIColor(hexString: category.color)
        let image = UIImage(data: category.imageAsData!)
        let imageView = UIImageView(image: image)
        let labelView = UILabel()
        let padding: CGFloat = 42
        categoriesButtons[index].addSubview(imageView)
        categoriesButtons[index].addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: categoriesButtons[index].leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: categoriesButtons[index].trailingAnchor, constant: -padding),
            imageView.topAnchor.constraint(equalTo: categoriesButtons[index].topAnchor, constant: 18),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            labelView.trailingAnchor.constraint(equalTo: categoriesButtons[index].trailingAnchor),
            labelView.leadingAnchor.constraint(equalTo: categoriesButtons[index].leadingAnchor),
            labelView.bottomAnchor.constraint(equalTo: categoriesButtons[index].bottomAnchor, constant: -13),
        ])
        labelView.text = category.name
        labelView.textAlignment = .center
        labelView.textColor = .white
        labelView.font = UIFont(font: FontFamily.PTSans.bold, size: 15)
        labelView.font = labelView.font.withSize(15)
        index += 1
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.text = L10n.homeDescription.uppercased()
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(font: FontFamily.PTSans.bold, size: 20)
        descriptionLabel.font = descriptionLabel.font.withSize(20)
    }

}



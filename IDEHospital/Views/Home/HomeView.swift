//
//  HomeView.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 08/12/2020.
//

import UIKit

class HomeView: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    var collectionView: UICollectionView!
    
    //MARK:- Proprties
    private var imageWidth: CGFloat {
        let widthRatio: CGFloat = UIScreen.main.bounds.width / 100
        let width: CGFloat = widthRatio * 22
        return width
    }
    
    //Setup Function to call from VC
    func setup() {
        configureBackground()
        configureDescriptionLabel()
        configureLogo()
        configureCollectionView()
    }
    
    func setupCollectionView(delgate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        collectionView.delegate = delgate
        collectionView.dataSource = dataSource
    }
    
    //MARK:- Private Functions
    
    private func configureBackground() {
        backgroundImage.image = UIImage(named: "splashBackGround")
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.frame = UIScreen.main.bounds
    }
    
    private func configureLogo(){
        logoImage.image = Asset.logo.image
        logoImage.contentMode = .scaleToFill
        logoImage.frame = CGRect(x: logoImage.frame.origin.x, y: logoImage.frame.origin.y, width: imageWidth, height: imageWidth)
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: creatTwoColumnFlowLayout())
        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: Cells.category)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func creatTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width
        let padding: CGFloat = 25
        let minimumItemSpacing: CGFloat = 15
        let avilableWidth = width - (padding * 2) - minimumItemSpacing
        let itemwidth = avilableWidth / 2
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.minimumLineSpacing = 25.0
        flowlayout.itemSize = CGSize(width: itemwidth, height: itemwidth)
        
        return flowlayout
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.text = L10n.homeDescription.uppercased()
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(font: FontFamily.PTSans.bold, size: 20)
        descriptionLabel.font = descriptionLabel.font.withSize(20)
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    //MARK:- Public Functions
}

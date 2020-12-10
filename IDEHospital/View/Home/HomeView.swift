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
    @IBOutlet var categoriesButtons: [UIButton]!
    @IBOutlet weak var logoImage: UIImageView!
    var collectionView: UICollectionView!
    
    //MARK:- Proprties
    var Categories = [Category]()
    
    //Setup Function to call from VC
    func setup() {
        configureBackground()
        configureDescriptionLabel()
        configureLogo()
        configureCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
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
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: creatTwoColumnFlowLayout())
        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
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
        let minimumItemSpacing: CGFloat = 25
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
    }
    
    //MARK:- Public Functions
    
    func setCategories(categories: [Category]){
        self.Categories = categories
        collectionView.reloadData()
    }
    
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.tag = Categories[indexPath.row].id
        cell.setupCell(color: Categories[indexPath.row].color,categoryTitle: Categories[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        print(cell.tag)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}



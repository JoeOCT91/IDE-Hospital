//
//  CategoryCollectionViewCell.swift
//  IDEHospital
//
//  Created by Yousef Mohamed on 10/12/2020.
//

import UIKit

class AppointmentDateCell: UICollectionViewCell {
    
    private let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(){
        contentView.addSubview(timeLabel)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        timeLabel.font = UIFont(font: FontFamily.PTSans.bold, size: 12)?.withSize(12)
        timeLabel.backgroundColor = ColorName.niceBlue.color
        timeLabel.adjustsFontSizeToFitWidth = true

        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        timeLabel.minimumScaleFactor = 0.85
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    

    func setupCell(title: String, backgroundColor: ColorName, isBooked: Bool){
        self.timeLabel.text = title
        self.timeLabel.backgroundColor = UIColor(named: backgroundColor)
        self.isUserInteractionEnabled = !isBooked
    }
    
    func selected(){
        timeLabel.backgroundColor = ColorName.darkRoyalBlue.color
    }
    func deSelected() {
        timeLabel.backgroundColor = ColorName.niceBlue.color
        
    }
}

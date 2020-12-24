//
//  SearchResultCell.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/22/20.
//

import UIKit
import SDWebImage
import Cosmos

class SearchResultCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var secondBioLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var watingTimeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeImageViewCirclerShape()
    }
    
    @IBAction func bookNowButtonPressed(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    //MARK:- Public Functions
    func configureCell(doctorName:String, doctorImage:String, rating:Double, ratingViewCount:Int, doctorSpecilty:String, secondBio:String, region:String, address:String, heartIamge:Bool, watingTime:Int, fees:Int) {
        self.nameLabel.text = doctorName
        self.profileImageView.sd_setImage(with:  URL(string: doctorImage), placeholderImage: Asset.placeholderImage.image)
        self.ratingView.rating = rating
        self.reviewCountLabel.text = "\(ratingViewCount)" + L10n.review
        self.specialtyLabel.text = doctorSpecilty
        self.secondBioLabel.text = secondBio
        self.regionLabel.text = region + ":" + address
        if heartIamge{
            heartImageView.image = Asset.redHeart.image
        }
        else{
            heartImageView.image = Asset.emptyHeart.image
        }
        self.watingTimeLabel.text = L10n.watingTime + "\(watingTime)" + L10n.minutes
        self.feesLabel.text = L10n.examinationFess + "\(fees)" + L10n.egyptionPound
    }
    // MARK:- Preivate Functions
    private func makeImageViewCirclerShape() {
          self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
          self.profileImageView.clipsToBounds = true;
      }
      
}

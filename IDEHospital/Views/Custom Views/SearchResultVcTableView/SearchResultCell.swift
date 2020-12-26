//
//  SearchResultCell.swift
//  IDEHospital
//
//  Created by Mostafa Saleh on 12/22/20.
//

import UIKit
import SDWebImage
import Cosmos

protocol sendDoctorIdDelegate {
    func getDoctorID(id:Int)
}
class SearchResultCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var secondBioLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var watingTimeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    private var currentDoctorID:Int!
    var sendDoctorDelegate:sendDoctorIdDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeImageViewCirclerShape()
       
    }
    @IBAction func heartButtonPressed(_ sender: Any) {
        
        print("Doctor ID" + " \(currentDoctorID)")
        
        self.sendDoctorDelegate?.getDoctorID(id: currentDoctorID)
        if heartButton.currentBackgroundImage == Asset.redHeart.image {
            self.heartButton.setBackgroundImage(Asset.emptyHeart.image, for: .normal)
        }
        else{
            self.heartButton.setBackgroundImage(Asset.redHeart.image, for: .normal)
        }
    }
    
    @IBAction func bookNowButtonPressed(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    //MARK:- Public Functions
    func configureCell(doctorID:Int, doctorName:String, doctorImage:String, rating:Double, ratingViewCount:Int, doctorSpecilty:String, secondBio:String, region:String, address:String, heartIamge:Bool, watingTime:Int, fees:Int) {
        self.currentDoctorID = doctorID
        self.nameLabel.text = doctorName
        self.profileImageView.sd_setImage(with:  URL(string: doctorImage), placeholderImage: Asset.placeholderImage.image)
        self.ratingView.rating = rating
        self.ratingView.settings.updateOnTouch = false
        self.reviewCountLabel.text = "\(ratingViewCount)" + L10n.review
        self.specialtyLabel.text = doctorSpecilty
        self.secondBioLabel.text = secondBio
        self.regionLabel.text = region + ":" + address
        switch heartIamge {
        case true:
            self.heartButton.setBackgroundImage(Asset.redHeart.image, for: .normal)
        default:
             self.heartButton.setBackgroundImage(Asset.emptyHeart.image, for: .normal)
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
